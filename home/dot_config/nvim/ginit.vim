" Author: Real Ferhat (@real-fht) <nferhat20@gmail.com>"
" Copyright: 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

" Neovide specific configuration.
" https://neovide.dev/configuration.html
if exists("g:neovide")
    set guifont=monospace:h11:#e-subpixelantialias:#h-slight

    " Keybind to zoom in and out, using scaling factor.
    let g:neovide_scale_factor=1.0
    function! <SID>ChangeScaleFactor(delta)
        let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
    endfunction
    " Zoom in and out by a factor of 1.05
    nnoremap <expr><C-=> <SID>ChangeScaleFactor(1.1)
    nnoremap <expr><C--> <SID>ChangeScaleFactor(1/1.1)

    " Transparency (buggy)
    " let g:neovide_transparency = 1
    " let g:transparency = 1
    " let g:neovide_background_color = '#000000DD'

    " Toggle fullscreen
    function! <SID>ToggleFullscreen()
        if g:neovide_fullscreen
            let g:neovide_fullscreen = v:false
        else
            let g:neovide_fullscreen = v:true
        endif
    endfunction
    nnoremap <expr><F11> <SID>ToggleFullscreen()

    " Funny cursor settings.
    let g:neovide_cursor_vfx_mode = "wireframe"
endif
