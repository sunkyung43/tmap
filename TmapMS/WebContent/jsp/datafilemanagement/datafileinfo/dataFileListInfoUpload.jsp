<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
  response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0
			response.setDateHeader("Expires", 0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tmap Managerment Site</title>
<!--  Stylesheet		-------------------------------------------------------------------------->
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/layout_contents.css" type="text/css" />
<link rel="stylesheet" href="css/upload.css" type="text/css" />
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow-y: auto;
	overflow-x: hidden;
}
</style>
<!--  JavaScript		-------------------------------------------------------------------------->
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/upload/swfupload.js"></script>
<script type="text/javascript" src="js/upload/swfupload.queue.js"></script>
<script type="text/javascript" src="js/upload/fileprogress.js"></script>
<script type="text/javascript" src="js/upload/handlers.js"></script>
<script type="text/javascript">
	var swfu;

	window.onload = function() {
		var settings = {
			flash_url : "js/upload/swfupload.swf",
			upload_url : "dataFileListInfoUpload.do",
			file_post_name : "uploadFileObj",
			post_params : {
				"fileVerId" : "${fileVerId}",
				"dataFileId" : "${dataFileId}",
				"fileVerName" : "${fileVerName}",
				"dataFileName": "${dataFileName}"
			},
			file_size_limit : "4098 MB",
			file_types : "*.*",
			file_types_description : "All Files",
			file_upload_limit : 300,
			file_queue_limit : 0,
			custom_settings : {
				progressTarget : "fsUploadProgress",
				cancelButtonId : "btnCancel"
			},
			debug : false,

			// Button settings
			button_image_url : "images/upload/TestImageNoText_65x29.png",
			button_width : "65",
			button_height : "29",
			button_placeholder_id : "spanButtonPlaceHolder",
			button_text : '<span class="theFont">파일선택</span>',
			button_text_style : ".theFont { font-size: 12; }",
			button_text_left_padding : 5,
			button_text_top_padding : 7,

			// The event handler functions are defined in handlers.js
			file_queued_handler : fileQueued,
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : fileDialogComplete,
			upload_start_handler : uploadStart,
			upload_progress_handler : uploadProgress,
			upload_error_handler : uploadError,
			upload_success_handler : uploadSuccessHandler,
			upload_complete_handler : uploadComplete,
			queue_complete_handler : queueComplete
		// Queue plugin event
		};

		swfu = new SWFUpload(settings);
	};

	function uploadSuccessHandler(file, serverData, responseReceived) {

		try {
			var progress = new FileProgress(file,
					swfu.customSettings.progressTarget);
			progress.setComplete();
			progress.setStatus("Complete.");
			progress.toggleCancel(false);
		} catch (ex) {
			this.debug(ex);
		}

		parent.callbackFileUploadUploadSuccess(serverData);
	}
</script>
<script type="text/javascript">
	
</script>
</head>
<body>
	<div>
		<p>
		<form name="ContentsForm" method="post">
			<form:hidden path="dataFileId" />
			<form:hidden path="fileVerId" />
            
			<div id="contents">
				<table>
					<tr>
						<td height="25"></td>
					</tr>
				</table>
				<table width="250" style="margin-left: 50px;">
					<tr>
						<td align="center">
							<!-- 내용 시작 -->
							<div class="fieldset flash" id="fsUploadProgress">
								<span class="legend">업로드 진행상황</span>
							</div>
							<div id="divStatus" style="margin-bottom: 10px;">0 file
								uploaded.</div>
							<div>
								<span id="spanButtonPlaceHolder"></span> <input id="btnCancel"
									type="button" value="모든 업로드 취소" onclick="swfu.cancelQueue();"
									disabled="disabled"
									style="margin-left: 2px; font-size: 8pt; height: 29px;" />
							</div> <!-- 내용 끝 -->
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</body>
</html>