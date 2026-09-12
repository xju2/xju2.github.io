/* Academic controls: keep citation text out of executable HTML attributes. */
(function () {
  function copyCitation(text) {
    function fallback() {
      var input = document.createElement("textarea");
      input.value = text;
      document.body.appendChild(input);
      input.select();
      document.execCommand("copy");
      input.remove();
    }
    if (navigator.clipboard && window.isSecureContext) {
      navigator.clipboard.writeText(text).catch(fallback);
    } else {
      fallback();
    }
  }

  document.addEventListener("click", function (event) {
    var button = event.target.closest("button[data-bibtex], button[data-paper-url]");
    if (!button) return;
    if (button.hasAttribute("data-paper-url")) {
      window.open(button.dataset.paperUrl, "_blank", "noopener");
      return;
    }

    var container = document.getElementById("bibTexContainer_" + button.dataset.postId);
    if (!container) return;
    if (container.style.display !== "none") {
      container.replaceChildren();
      container.style.display = "none";
      button.setAttribute("aria-expanded", "false");
      return;
    }

    var citation = button.dataset.bibtex
      .replace(/\\n/g, "\n")
      .replace(/&lbrace;/g, "{")
      .replace(/&rbrace;/g, "}");
    container.textContent = citation;
    container.style.display = "block";
    button.setAttribute("aria-expanded", "true");
    var copy = document.createElement("button");
    copy.type = "button";
    copy.className = "copy-button";
    copy.textContent = "Copy BibTeX";
    copy.addEventListener("click", function () { copyCitation(citation); });
    container.appendChild(copy);
  });
})();
