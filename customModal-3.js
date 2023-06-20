function setupCustomModal(tag,title,body,buttonList,cancelButton = "") {
  document.getElementById("modalContent-" + tag).innerHTML = "";
  document.getElementById("modalContent-" + tag).innerHTML = body;
  titleDiv = document.getElementById("modalTitle-" + tag);
  titleDiv.innerHTML = title;
  footerElement = document.getElementById("modalFooter-" + tag);
  buttonList.forEach((button) => {
    var extraProperties = button.length == 1 ? "" : button[1];
    var idText = button[0]
      .toLowerCase()
      .replace(/[^a-zA-Z0-9]+(.)/g, (m, chr) => chr.toUpperCase());
    $(`#modalFooter-${tag}`).prepend(
      `<button type="submit" id=${idText} ${extraProperties} class="btn btn-success">${button[0]}</button>`
    );
  });
  var cancleButtonValue = cancelButton === "" ? "Cancle" : cancelButton;
  $(`#modalFooter-${tag}`).prepend(
    `<button type="button" class="btn btn-default" data-dismiss="modal">${cancleButtonValue}</button>`
  );
}
