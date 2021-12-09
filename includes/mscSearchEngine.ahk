mscSearchEngine := new mscSearchEngine()
class mscSearchEngine extends MasterScriptCommands {
    mscSearch(oOptions*) {
    	; Title,Subtitle := "What would you like to search?",Color := "",Icon := ""
    	global neutron
    	static oKeys := ["title","subTitle","icon","color","background"]
    	      ,searchParams := {title:"Custom Search"
    						   ,subTitle:"What would you like to search?"
    						   ,icon:"./Icons/AHK.ico"
    						   ,color:"#00FF00"
    						   ,background:"#00FF00"}
    
    	for key,value in oOptions.1 {
    		Loop, % oKeys.Length() {
    			if (key = oKeys[A_Index])
    				searchParams[oKeys[A_Index]] := value
    		}
    	}
    	; neutron.wnd.Eval("$('.mscIcon').css('background','url(""" searchParams.icon """) no-repeat center center')")
    	neutron.wnd.Eval("$('.mscIcon').attr('src','" mscUtilities.escapeBackSlash(searchParams.icon) "')")
    	neutron.wnd.Eval("$('.mscTitle').text('" searchParams.title "')")
    	neutron.wnd.Eval("$('.mscTitle').css('color', '" searchParams.color "')")
    	neutron.wnd.Eval("$('#search:focus').css({'border-color': '" searchParams.color "', 'box-shadow': 'inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px " searchParams.color "'})")
    
    	; change ID of search to enable search functions
    	neutron.wnd.Eval("$('#search').attr('id','mscSearchInput')")
    	; Show Newly Changed Window
    	toggleMSC(neutron)
    	; Focus new Search Edit Field
    	neutron.wnd.Eval("$('#mscSearchInput').focus()")
    	return
    }
    mscAddElements(gui_SearchEdit) {
    	for key, value in MSC_Search {
    		vURL := StrReplace(value, "REPLACEME", uriEncode(gui_SearchEdit))
    		DMD_Run(vURL)
    		Search_Title := RegExReplace(value, "s).*?(\d{12}).*?(?=\d{12}|$)", "$1`r`n")
    		If (Title = "" ? Title := Search_Title : Title := Title)	
    			t("<i style='font-size:0.75rem'>" vURL "</i>",{title:gui_SearchEdit,time:3000,stack:1}) 
    	}
    	MSC_Search := [] ; reset for adding search urls into MSC_Search
    }
    mscSearchUrls(url) {
    	global MSC_Search
    	if (IsObject(url)) {
    		for key,value in url {
    			MSC_Search.Push(value)
    		}
    		return
    	}
    	MSC_Search.Push(url)
    }
}