app = angular.module('instantUpload', [])

@multiIuCtrl = ['$scope', '$element', ($scope, $element) ->

  # upload event handler
  class UploadHandler

    constructor: ($uploader) ->
      @url = $uploader.parents('form').attr('action')

      $scope.persisted = $uploader.data('persisted')
      $scope.limit = $uploader.data('limit')
      $scope.multi = $uploader.data('multi')
      $scope.version = $uploader.data('version')

      @uploader = $uploader
      @element = $uploader.find('.iu-multi-dropzone')

      @element.bind 'dragenter', @dragEnter
      @element.bind 'dragover',  @dragEnter
      @element.bind 'dragleave', @dragLeave
      @element.bind 'drop',      @drop

      $fileInput = $uploader.find('input[type="file"]')
      $fileInput.bind 'change', @drop

      $uploader.find('.iu-multi-select').show 0, ->
        $selectFiles = $uploader.find('.iu-multi-select-files')
        offset = $selectFiles.position()

        $fileInput.css
          opacity: 0
          cursor: 'pointer'
          position: 'absolute'
          left: offset.left
          top: offset.top
          width: $selectFiles.width() + 10
          height: $selectFiles.height() + 10
          'margin-left': -5
          'margin-top': -25
          'z-index': 2
          '-ms-filter': '"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)"'
          'filter': 'alpha(opacity=0)'

      @fileinput = $fileInput

    dragEnter: (e) =>
      # console.log 'dragEnter'

      e.stopPropagation()
      e.preventDefault()

      @element.addClass 'iu-drag-over'

      # settings.dragEnter(e)
      return false

    dragLeave: (e) =>
      # console.log 'dragLeave'

      e.stopPropagation()
      e.preventDefault()

      @element.removeClass 'iu-drag-over'

      # settings.dragLeave(e)
      return false

    drop: (e) =>
      # console.log 'drop'

      e.stopPropagation()
      e.preventDefault()

      @element.removeClass 'iu-drag-over'

      # get files from drag and drop dataTransfer
      if typeof e.originalEvent.dataTransfer == 'undefined'
        files = e.originalEvent.target.files
      else
        files = e.originalEvent.dataTransfer.files

      if $scope.limit != undefined && $scope.files.length + files.length > parseInt($scope.limit)
        @uploader.find('.iu-alert').show()
        return

      fd = new FormData

      for file in files
        fd.append @fileinput.attr('name'), file

      $scope.$apply ->
        $scope.uploaded = false
        $scope.uploadProgress = 0

      xhr = new XMLHttpRequest

      xhr.upload.addEventListener 'progress', ( (e) =>
        # console.log 'progress'
        percent = Math.ceil(e.loaded / e.total * 100)
        $scope.$apply ->
          $scope.uploadProgress = percent
      ), false

      xhr.addEventListener 'load',  ( (e) =>
        # console.log 'load'
        $scope.$apply ->
          $scope.uploaded = true

          # $scope.files = []
          for image in $.parseJSON(xhr.response)
            $scope.files.push { path: image[$scope.multi][$scope.version].url }
      ), false

      xhr.addEventListener 'error', ( (e) =>
        # console.log 'error'
      ), false

      xhr.addEventListener 'abort', ( (e) =>
        # console.log 'abort'
      ), false


      if $scope.persisted
        method = 'PATCH'
      else
        method = 'POST'

      xhr.open method, "#{@url}.json"
      xhr.setRequestHeader 'X-Instant-Upload', true
      xhr.send fd

      return false


  $scope.init = ($uploader) ->
    handler = new UploadHandler($uploader)
    $uploader.find('.iu-multi-dropzone').addClass('active')
    $uploader.find('.iu-multi-files').show()

    $scope.files = []

    $scope.$apply ->
      $uploader.find('.iu-multi-files-cache li').each ->
        $scope.files.push { path: $(this).find('img').attr('src') }

  $ -> $scope.init($($element)) if !!window.FormData

]
