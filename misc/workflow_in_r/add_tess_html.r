
add_tess_html <- function(id, target) {
  system(paste0("echo \"<h4 id='tess-widget-materials-header'></h4>\" >> ", target))
  system(paste0("echo \"\" >> ", target))
  
  system(paste0("echo \"<div id='tess-widget-materials-list' class='tess-widget tess-widget-list'></div>\" >> ", target))
  system(paste0("echo \"<script>\" >> ", target))
  system(paste0("echo \"  function initTeSSWidgets() {\" >> ", target))
  system(paste0("echo \"    var query = '", id, "';\" >> ", target))
  system(paste0("echo \"    if (query.trim() != '') {\" >> ", target))
  system(paste0("echo \"      TessWidget.Materials(document.getElementById('tess-widget-materials-list'),\" >> ", target))
  system(paste0("echo \"                           'SimpleList',\" >> ", target))
  system(paste0("echo \"                           {\" >> ", target))
  system(paste0("echo \"                             opts: {\" >> ", target))
  system(paste0("echo \"                               enableSearch: false\" >> ", target))
  system(paste0("echo \"                             },\" >> ", target))
  system(paste0("echo \"                             params: {\" >> ", target))
  system(paste0("echo \"                               pageSize: 5,\" >> ", target))
  system(paste0("echo \"                               q: query\" >> ", target))
  system(paste0("echo \"                             }\" >> ", target))
  system(paste0("echo \"                           });\" >> ", target))
  system(paste0("echo \"      document.getElementById('tess-widget-materials-header').innerHTML = 'Documentation from ELIXIR TeSS'\" >> ", target))
  system(paste0("echo \"    }\" >> ", target))
  system(paste0("echo \"}\" >> ", target))
  system(paste0("echo \"</script>\" >> ", target))
  system(paste0("echo \"<script async='' defer='' src='https://elixirtess.github.io/TeSS_widgets/components/js/tess-widget-standalone.js' onload='initTeSSWidgets()'></script>\" >> ", target))
}


  
    