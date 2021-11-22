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

function getFaIcon(icon) {
  return '<i class="fa fa-' + icon + '"></i>' + " " // icon + spacer
}

$(document).keyup(function (event) {
  // Enable Enter Key for MsgPopup, currently only need keyup not keydown+keyup
  if (event.keyCode == 13) {
    Swal.clickConfirm()
  }
  // Ctrl+C will click Clipboard button (or denied button)
  if (event.keyCode == 67 && event.ctrlKey) {
    Swal.clickDeny()
  }
  // Ctrl+X will ExitApp
  if (event.keyCode == 88 && event.ctrlKey) {
    Swal.clickCancel()
  }
  // Esc key will close neutron instead of closing MSC
  if (event.keyCode == 27) {
    ahk.mscEscapeKey()
  }
  // alt+F12 key will open developer tools
  if (event.keyCode == 123) {
    ahk.runIEChooser()
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
      let query = $("#search").val()
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
        '<div class="col-md-7" id="divResultsCommand">' +
        vCommand +
        "</div>" +
        '<div class="col-md-5" id="divResultsComment">' +
        vComment +
        "</div>" +
        "</div>"
    )

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
    // focus the input field on neutron.Show
    // $("#mscSearch").focus()
    $("#search").focus()

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
  })
}
