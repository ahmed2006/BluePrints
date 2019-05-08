<#if comments?? && comments?size != 0>
    <#list comments as comment>
      <tr>
        <td>
          <div class="row">

            <div class="col-lg-8">
              ${comment.creator.firstName} ${comment.creator.lastName}:<br> <span id="${comment.id}">${comment.message}</span>
            </div>
            <div class="col-lg-4" align="center" style="align-items: center; display: flex;">
              <a href="javascript:deleteCommentPopup('${comment.id}')" style="text-decoration: none; color: red; padding-right: 0.5em;" class="deleteCommentBtn">Delete</a>
              <a href="javascript:editCommentPopup('${comment.id}')" style="text-decoration: none;" class="editCommentBtn">Edit</a>
            </div>
          </div>
        </td>
      </tr>
    </#list>
<#else>
  <tr><td align="center">No Comments Found</td></tr>
</#if>
