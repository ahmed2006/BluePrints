  <div class="card floorPanel">
    <div class="card-header">
      Floor Information
    </div>

    <div class="card-block col-lg-12">

      <div class="row">
        <div class="container-fluid">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="/BluePrints/mapManager">${floor.building.name}</a></li>
              <li class="breadcrumb-item active" aria-current="page">Floor ${floor.name}</li>
            </ol>
          </nav>
        </div>
      </div>

      <div class="row">
        <div class="col-lg-8">
          <br><h3><b>Floor: ${floor.name}</b></h3>
        </div>
      </div>

      <div class="row">
        <div class="col-lg-12">
          <table class="table" border="1" id="roomTable" style="border-collapse: collapse;">
            <thead class="thead-dark">
              <tr>
                <th>
                  <div class="row">
                    <div class="col-sm-6">
                      <h4><b>Rooms</b></h4>
                    </div>
                    <div class="col-sm-6" align="right">
    								  <button class="btn btn-primary" style="border: 2px solid white; background-color: #212529;" id="drawRoom">Add Room</button>
    								</div>
                  </div>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr id="roomTableRow">
                <td id="roomTableCell">
                  <table class='table' border="0">
                      <thead>
                        <tr><th>Name</th><th>Actions</th></tr>
                      </thead>
                      <tbody id="roomSection">

                      </tbody>
                  </table>
                </td>
              </tr>
            </tbody>
            <tbody>
              <tr>
                <td>
                  <button class="btn btn-danger" id="clearBtn">
                    <span class="fas fa-trash-alt"></span> Clear
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

        <div class="row">
          <div class="col-lg-12">
            <table class="table" border="1" id="commentTable">
              <thead class="thead-dark"><tr><th>Comments</th></tr></thead>
              <tbody id="commentSection">
              </tbody>
              <tbody>
                  <tr>
                    <td>
                        <div class="row col-lg-12">
                          <div class="col-lg-10">
                            <input type="text" name="commentMsg" id="commentMsg" placeholder="Enter Comment" class="form-control">
                          </div>
                          <div class="col-lg-2">
                            <button class="btn btn-secondary" id="sendMessageBtn">Submit</button>
                          </div>
                        </div>
                    </td>
                  </tr>
              </tbody>
            </table>
          </div>
        </div>

          <input type="hidden" value="${activeUser.id}" id="editorId">

          <div class="row">
            <div class="col-lg-12" align="right" style="margin: 0 0 10px -10px;">
              <button class="btn btn-secondary back" onclick="window.location='/BluePrints/mapManager'">Back</button>
            </div>
          </div>
    </div>
</div>
