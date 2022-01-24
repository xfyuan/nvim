local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
" &&%                      ---.____    ,/k.                                    && ",
"  &&&&&&&                   ___,---'  /  ih,__,-----.___               .&&&&&&&  ",
"   &#&&&&&&& &,                    ,-' ,  `:7b----.__---`         %& &&&&&&&.&   ",
"     &&&&&&&&&&&&&             _.-/   '  /b.`.4p,              &&&&&&&&&&&&&     ",
"      %&&&&&&&&&&&&&        --'  ,    ,-' ^6x, `.'^=._       &&&&&&&&&&&&&       ",
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
"                                NeoVim for XY v0.6                               ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e",          "  New file" , ":enew <CR>"),
    dashboard.button( "u",          "  Update plugins" , ":PackerUpdate<CR>"),
    dashboard.button( "Leader h f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button( "Leader h o", "  Recent files"   , ":Telescope oldfiles<CR>"),
}

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)

-- Send config to alpha
alpha.setup(dashboard.opts)
