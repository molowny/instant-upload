app = angular.module('instantUpload', [])

@singleIuCtrl = ['$scope', '$element', ($scope, $element) ->

  # upload event handler
  class UploadHandler

    constructor: ($uploader) ->
      @url = $uploader.parents('form').attr('action')
      @persisted = $uploader.data('persisted')

      @element = $uploader.find('.iu-simple-dropzone')

      @element.bind 'dragenter', @dragEnter
      @element.bind 'dragover',  @dragEnter
      @element.bind 'dragleave', @dragLeave
      @element.bind 'drop',      @drop

      $fileInput = $uploader.find('input[type="file"]')
      $fileInput.bind 'change', @drop

      $uploader.find('.iu-simple-select').show 0, ->
        $selectFiles = $uploader.find('.iu-simple-select-files')
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
      # console.log e

      e.stopPropagation()
      e.preventDefault()

      @element.removeClass 'iu-drag-over'

      dataTransfer = e.dataTransfer = e.originalEvent && e.originalEvent.dataTransfer

      # get files from drag and drop dataTransfer
      if typeof e.originalEvent.dataTransfer == "undefined"
        files = e.originalEvent.target.files
      else
        files = e.originalEvent.dataTransfer.files

      fd = new FormData
      fd.append 'user[avatar]', files[0]
        

      xhr = new XMLHttpRequest

      $scope.$apply ->
        $scope.uploaded = false
        $scope.uploadProgress = 0

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

        @element.find('img').attr('src', $.parseJSON(xhr.response).image)
      ), false

      xhr.addEventListener 'error', ( (e) =>
        # console.log 'error'
      ), false

      xhr.addEventListener 'abort', ( (e) =>
        # console.log 'abort'
      ), false

      
      if @persisted
        metchod = 'PATCH'
      else
        method = 'POST'

      xhr.open method, "#{@url}.json"
      # xhr.setRequestHeader 'X-Slider-Id', res.slider.id
      xhr.send fd

      return false


  $scope.init = ($uploader) ->
    handler = new UploadHandler($uploader)

    # set width of the dropzone div for progressbar
    $uploader.find('.iu-simple-dropzone').each ->
      $this = $(this)
      
      width = $this.find('img').width()
      height = $this.find('img').height()

      $this.width width
      $this.height height

      $this.find('img').css 'width', width
      $this.find('img').css 'height', height

  # to fix problem with offset in WebKit browsers


  $ -> $scope.init($($element)) if !!window.FormData

]
