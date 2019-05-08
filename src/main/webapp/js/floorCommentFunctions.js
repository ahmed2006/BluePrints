function reloadComments(floorId) {
   $.ajax({
     url: "/BluePrints/mapManager/floor/getComments",
     type: "GET",
     data: {
       floorId: floorId
     },
     success: function(html) {
         $("#commentSection").html(html);
     },
     error: printError
   });
}

function addComment(floorId, activerUserId, msg, successFunction, errorFunction) {

  $.ajax({
    url: "/BluePrints/mapManager/floor/addComment",
    type: "POST",
    dataType: "json",
    data: {
      floorId: floorId,
      creatorId: activerUserId,
      commentMsg: msg
    },
    success: successFunction,
    error: errorFunction
  });
}

function updateComment(activerUserId, commentId, msg, successFunction, errorFunction) {
  $.ajax({
    url: "/BluePrints/mapManager/floor/updateComment",
    type: "POST",
    dataType: "json",
    data: {
      commentId: commentId,
      creatorId: activerUserId,
      commentMsg: msg
    },
    success: successFunction,
    error: errorFunction
  });
}

function deleteComment(activeUserId, commentId, successFunction, errorFunction) {
  $.ajax({
    url: "/BluePrints/mapManager/floor/deleteComment",
    type: "POST",
    dataType: "json",
    data: {
      userId: activeUserId,
      commentId: commentId
    },
    success: successFunction,
    error: errorFunction
  })
}
