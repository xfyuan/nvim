local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
" &&%                     ---.____    ,/x.                                      &&",
"  &&&&&&&                  ___,---'  /  ia,__,-----.___                 .&&&&&&& ",
"   &#&&&&&&& &,                   ,-' ,  `:7o----.__---`           %& &&&&&&&.&  ",
"     &&&&&&&&&&&&&            _.-/   '  /f.`.en,                &&&&&&&&&&&&&    ",
"      %&&&&&&&&&&&&&       --'  ,    ,-' ^6g, `.'^=._         &&&&&&&&&&&&&      ",
"        *&&&&&&&&&&&&&&&.                                &&&&&&&&&&&&&&&         ",
"           &* &&&&&& &&&&&&&                         &&&&&&&/&&&&&& (&           ",
"              &&&&&&&&&* &&&&&                     &&&&& &&&&&&&&&&              ",
"                &&&&&&&&&&* &&&&&               &&&&& &&&&&&&&&&&                ",
"                   &&&&&&&&&&  &&&%            &&&  &&&&&&&&&&                   ",
"                      &%/#&&&&&, &&&&       .&&& &&&&&&#/&%                      ",
"                          %&&&&&&& &&      .&& &&&&&&&/                          ",
"                                 *&&         &&.                                 ",
"                                     %     &                                     ",
"                                                                                 ",
"                       ✯¸.•´✿¨`✯•❀     &&&     ✿•✯`¨❀`•.¸✯                       ",
"                                     %&   &                                      ",
"                                    ✿       ❀                                    ",
"                                   ✿         ❀                                   ",
"                                  ✿           ❀                                  ",
"                                                                                 ",
"                               The NeoVim of XY v0.8                             ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e",          "  New file" , ":enew <CR>"),
    dashboard.button( "u",          "  Update plugins" , ":PackerUpdate<CR>"),
    -- dashboard.button( "Leader f f", "  Find file", ":Telescope find_files<CR>"),
    -- dashboard.button( "Leader f h", "  Recent files"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "Leader f h", "  Recent files"   , ":Telescope oldfiles<CR>"),
}

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)

-- Send config to alpha
alpha.setup(dashboard.opts)
