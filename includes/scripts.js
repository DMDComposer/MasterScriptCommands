;(function ($) {
  $.fn.innerText = function (msg) {
    if (msg) {
      if (document.body.innerText) {
        for (var i in this) {
          this[i].innerText = msg
        }
      } else {
        for (var i in this) {
          this[i].innerHTML
            .replace(/&amp;lt;br&amp;gt;/gi, "n")
            .replace(/(&amp;lt;([^&amp;gt;]+)&amp;gt;)/gi, "")
        }
      }
      return this
    } else {
      if (document.body.innerText) {
        return this[0].innerText
      } else {
        return this[0].innerHTML
          .replace(/&amp;lt;br&amp;gt;/gi, "n")
          .replace(/(&amp;lt;([^&amp;gt;]+)&amp;gt;)/gi, "")
      }
    }
  }
})(jQuery)

// Attempt to disable JS errors that break AHK scripts
$(document).ready(function () {
  this.ScriptErrorsSuppressed = true
  console.warn = function () {}
})

function getFaIcon(icon) {
  return '<i class="fa fa-' + icon + '"></i>' + " " // icon + spacer
}

$(document).keyup(function (event) {
  if (event.keyCode == 13) {
    // var e = document.getElementById("resultsList")
    // var command = e.options[e.selectedIndex].text

    if ($(".divClassResultsCommand").hasClass("resultSelected")) {
      const command = $(".resultSelected").text()
      // alert(command)
      // alert($(this).text())
      ahk.getCommand(command)
    }

    if ($("#mscSearchInput").length) {
      ahk.setMSCSearchParam($("#mscSearchInput").val())
    }

    if ($("#mscRunAHKCommandInput").length) {
      ahk.getMSCRunAHKCommand($("#mscRunAHKCommandInput").val())
    }
  }
  // Esc key will close neutron instead of closing MSC
  if (event.keyCode == 27) {
    // ahk.mscEscapeKey()
    ahk.resetMSCWnd("")
  }
  // F12 key will open developer tools
  if (event.keyCode == 123) {
    ahk.runIEChooser()
  }
  // F11 key will reload script
  if (event.keyCode == 122) {
    ahk.reloadScript()
  }
  // F5 key will reload script
  if (event.keyCode == 116) {
    alert("hi")
  }
})

////////////////////////////////////////////////////////////////
// Search Functions
////////////////////////////////////////////////////////////////
// Delay search results in case user is completing word and typing fast
// https://stackoverflow.com/questions/1909441/how-to-delay-the-keyup-handler-until-the-user-stops-typing
function delay(callback, ms) {
  let timer = 0
  return function () {
    let context = this,
      args = arguments
    clearTimeout(timer)
    timer = setTimeout(function () {
      callback.apply(context, args)
    }, ms || 0)
  }
}
$(document).ready(function () {
  $("#search").keyup(
    delay(function (e) {
      let query = $("#search").length ? $("#search").val() : ""
      query.length > 0 ? filter(query) : show_all() // if input field has 1 or more characters, filter results otherwise show_all()
    }, 50)
  )
})

const items = [] // have to declare array empty first
function getItems(i, entry) {
  // value cap has to match what the JSON object is (or what is in my Sheet),
  // the key has to match what I do with it below
  // const items for AHK SQLite Conversion
  const items = {
    id: i,
    command: entry[i].command,
    comment: entry[i].comment,
  }
  return items
}

// if I want to stop all stop words, add "elasticlunr.clearStopWords()" to document.ready function
elasticlunr.clearStopWords = function () {
  elasticlunr.stopWordFilter.stopWords = {}
}

let index = elasticlunr(function () {
  const entries = ["command", "comment"]
  for (let i in entries) {
    this.addField(entries[i])
  }
  this.setRef("id") // this is on by default and doesn't need to be here
})

function show_all() {
  elasticlunr.clearStopWords() // removes elasticlunr stopwords, so you can search for single letters
  $(".results").empty()
  $("#search").css({ transition: "all .25s ease-in-out" })
  $("#search").removeClass("form-group col-md-11")
  $("#search").addClass("form-group col-md-12")
  $(".div-resultsTotal").empty()
  $(".results").append(
    "<div class='resultsEmpty' style='font-style: italic; width: max-content;'>" +
      getFaIcon("search") +
      "Search results will be displayed after your first query...</div>"
  )
  /* for (i in items) {
    // alert(items[i].command)
    $(".results").append(
      "<h3>" +
        items[i].command +
        "</h3><p>" +
        items[i].comment +
        "<br>" +
        "</p><hr>"
    )
  } */
}

function filter(query) {
  let filter_results = index.search(query, {
    fields: {
      command: { boost: 2, bool: "OR" },
      comment: { boost: 1 },
    },
    bool: "OR",
    expand: true,
  })

  $(".results").empty()
  for (i in filter_results) {
    let vCommand = filter_results[i].doc.command,
      vComment = filter_results[i].doc.comment
    // alert(vCommand)
    $(".results").append(
      // Title Info Start
      '<div class="container-flex resultsFiltered" id="div-resultsFiltered">' +
        '<div class="col-md-7 divClassResultsCommand" id="divResultsCommand">' +
        vCommand +
        "</div>" +
        '<div class="col-md-5" id="divResultsComment">' +
        vComment +
        "</div>" +
        "</div>"
    )

    /* $("#resultsList").append(
      '<option value="' + i + '">' + vCommand + "</option>"
    ) */

    // Total number of commands displayed and total overall
    let vTotalQueries = $(".resultsFiltered").length
    let vTotalRowCount = vTotalQueries + " / " + ahk.getCommandTotal()
    $(".div-resultsTotal").text(vTotalRowCount)
  }
}

////////////////////////////////
// AHK onReady Function
////////////////////////////////

function onReady(event) {
  const entry = JSON.parse(ahk.getDB(event)) // have to convert from string to JSON object
  //   alert(entry[1].command)
  for (i in entry) {
    items.push(getItems(i, entry))
    index.addDoc(getItems(i, entry))
  }
  $(document).ready(function () {
    if ($("#search").length) {
      // focus the input field on neutron.Show
      $("#search").focus()

      // currently, ElasticJr will be buggy unless user interaction
      // happens before the first search. Below fixes it
      jQueryKeyPress("#search", 8)

      // on keyUp send current edit field value to AHK
      $("#search").keyup(function () {
        let wndW = $(".search").width(),
          wndH = $(".results").height(),
          mscInput = $("#search").val()
        // wndH = $(".search").height()
        // wndH = $("#divMSCResults").height()

        ahk.updateWndSize(wndW, wndH, mscInput)
        ahk.getCommand(mscInput)
      })
    }
  })
}

function jQueryKeyPress(selector, keyCode) {
  $(selector).trigger($.Event("keydown", { keyCode: keyCode }))
  $(selector).trigger($.Event("keyup", { keyCode: keyCode }))
  return
}

const setHighlightCSS = {
    background: "red",
    transform: "scale(1.1)",
    transition: "transform 250ms ease-in-out",
  },
  removeHighlightCSS = { background: "", transform: "", transition: "" }

let scrollIntDefault = 12
let scrollInt = scrollIntDefault

function highlightNextDiv(next) {
  const prev = next - 1
  $(".resultsFiltered")
    .eq(next)
    .children("#divResultsCommand")
    .css(setHighlightCSS)

  $(".resultsFiltered")
    .eq(next)
    .children("#divResultsCommand")
    .addClass("resultSelected")

  $(".resultsFiltered")
    .eq(prev)
    .children("#divResultsCommand")
    .css(removeHighlightCSS)

  $(".resultsFiltered")
    .eq(prev)
    .children("#divResultsCommand")
    .removeClass("resultSelected")

  // ahk.xxyy(next)
  // to auto scroll when highligh is past the preview of the GUI
  if (next >= scrollInt) {
    $(".results").scrollTo(".resultSelected")
    scrollInt += scrollIntDefault
  }
  return next
}

function highlightPrevDiv(next) {
  const prev = next - 1
  // to auto scroll when highligh is past the preview of the GUI
  if (prev == scrollInt - scrollIntDefault - 1 && prev > 6) {
    $(".results").scrollTo($(".resultsFiltered").eq(prev - 11))
    scrollInt -= scrollIntDefault
  }

  $(".resultsFiltered")
    .eq(prev)
    .children("#divResultsCommand")
    .css(setHighlightCSS)

  $(".resultsFiltered")
    .eq(prev)
    .children("#divResultsCommand")
    .addClass("resultSelected")

  $(".resultsFiltered")
    .eq(next)
    .children("#divResultsCommand")
    .css(removeHighlightCSS)

  $(".resultsFiltered")
    .eq(next)
    .children("#divResultsCommand")
    .removeClass("resultSelected")

  // ahk.xxyy(prev)
  return prev
}

function resetHighlightedDiv(next) {
  $(".resultsFiltered")
    .eq(next)
    .children("#divResultsCommand")
    .css(removeHighlightCSS)

  $(".resultsFiltered")
    .eq(next)
    .children("#divResultsCommand")
    .removeClass("resultSelected")
  scrollInt = scrollIntDefault
}

function resetSearchAttributes() {
  if ($("#mscSearchInput").length) {
    $("#mscSearchInput").attr("id", "search")
  }
  if ($("#mscRunAHKCommandInput").length) {
    $("#mscRunAHKCommandInput").attr("id", "search")
  }
  // $(".mscIcon").css("background", 'url("./Icon.ico") no-repeat center center')
  $(".mscIcon").attr("src", "../Icon.ico")
  $(".mscTitle").text("Master Script Commands")
  $(".mscTitle").css("color", "#fff")
  $("#search").css({
    color: "#fff",
    "background-color": "#1d1f21",
  })
  $("#search:focus").css({
    "border-color": "rgba(255, 0, 0, 0.6)",
    "box-shadow":
      "inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(255, 0, 0, 0.6)",
  })
}
