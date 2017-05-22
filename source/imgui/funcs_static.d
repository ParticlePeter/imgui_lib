/*
 * Copyright (  c  ) 2015 Derelict Developers
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the names 'Derelict', 'DerelictILUT', nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (  INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION  ) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (  INCLUDING
 * NEGLIGENCE OR OTHERWISE  ) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module imgui.funcs_static;

import imgui.types;
import core.stdc.stdarg : va_list;

extern( C++, ImGui ) nothrow @nogc {

    // Main
    ref ImGuiIO     GetIO();
    ref ImGuiStyle  GetStyle();
    ImDrawData*     GetDrawData();                                  // same value as passed to your io.RenderDrawListsFn() function. valid after Render() and until the next call to NewFrame()
    void            NewFrame();                                     // start a new ImGui frame, you can submit any command from this point until NewFrame()/Render().
    void            Render();                                       // ends the ImGui frame, finalize rendering data, then call your io.RenderDrawListsFn() function if set.
    void            Shutdown();
    void            ShowUserGuide();                                // help block
    void            ShowStyleEditor( ImGuiStyle* style = null );    // style editor block. you can pass in a reference ImGuiStyle structure to compare to, revert to and save to ( else it uses the default style )
    void            ShowTestWindow( bool* p_open = null );          // test window demonstrating ImGui features
    void            ShowMetricsWindow( bool* p_open = null );       // metrics window for debugging ImGui ( browse draw commands, individual vertices, window list, etc. )

    // Window
    bool            Begin( const( char )* name, bool* p_open = null, ImGuiWindowFlags flags = 0 );                                      // push window to the stack and start appending to it. see .cpp for details. return false when window is collapsed, so you can early out in your code. 'bool* p_open' creates a widget on the upper-right to close the window ( which sets your bool to false ).
    bool            Begin( const( char )* name, bool* p_open, const ref ImVec2 size_on_first_use, float bg_alpha = -1.0f, ImGuiWindowFlags flags = 0 ); // OBSOLETE. this is the older/longer API. the extra parameters aren't very relevant. call SetNextWindowSize() instead if you want to set a window size. For regular windows, 'size_on_first_use' only applies to the first time EVER the window is created and probably not what you want! might obsolete this API eventually.
    void            End();                                                                                                              // finish appending to current window, pop it off the window stack.
    bool            BeginChild( const( char )* str_id, const ref ImVec2 size, bool border = false, ImGuiWindowFlags extra_flags = 0 );  // begin a scrolling region. size==0.0f: use remaining window size, size<0.0f: use remaining window size minus abs( size ). size>0.0f: fixed size. each axis can use a different mode, e.g. ImVec2( 0, 400 ).
    bool            BeginChild( const( char )* str_id ) {        ImVec2 size = ImVec2( 0, 0 ); return BeginChild( str_id, size ); }     // original parameter is const ref ImVec2 size = ImVec2( 0, 0 )
    bool            BeginChild( ImGuiID id, const ref ImVec2 size, bool border = false, ImGuiWindowFlags extra_flags = 0 );             // is const ref ImVec2 size = ImVec2( 0, 0 )
    bool            BeginChild( ImGuiID id  )  {      ImVec2 size = ImVec2( 0, 0 ); return BeginChild( id, size ); }                    // with this overloads we simulate the original behavior
    void            EndChild();
    ImVec2          GetContentRegionMax();                                                  // current content boundaries ( typically window boundaries including scrolling, or current column boundaries ), in windows coordinates
    ImVec2          GetContentRegionAvail();                                                // == GetContentRegionMax() - GetCursorPos()
    float           GetContentRegionAvailWidth();                                           //
    ImVec2          GetWindowContentRegionMin();                                            // content boundaries min ( roughly ( 0, 0 )-Scroll ), in window coordinates
    ImVec2          GetWindowContentRegionMax();                                            // content boundaries max ( roughly ( 0, 0 )+Size-Scroll ) where Size can be override with SetNextWindowContentSize(), in window coordinates
    float           GetWindowContentRegionWidth();                                          //
    ImDrawList*     GetWindowDrawList();                                                    // get rendering command-list if you want to append your own draw primitives
    ImVec2          GetWindowPos();                                                         // get current window position in screen space ( useful if you want to do your own drawing via the DrawList api )
    ImVec2          GetWindowSize();                                                        // get current window size
    float           GetWindowWidth();
    float           GetWindowHeight();
    bool            IsWindowCollapsed();
    void            SetWindowFontScale( float scale );                                      // per-window font scale. Adjust IO.FontGlobalScale if you want to scale all windows

    void            SetNextWindowPos( const ref ImVec2 pos, ImGuiSetCond cond = 0 );        // set next window position. call before Begin()
    void            SetNextWindowPosCenter( ImGuiSetCond cond = 0 );                        // set next window position to be centered on screen. call before Begin()
    void            SetNextWindowSize( const ref ImVec2 size, ImGuiSetCond cond = 0 );      // set next window size. set axis to 0.0f to force an auto-fit on this axis. call before Begin()
//  void            SetNextWindowSizeConstraints( const ref ImVec2 size_min, const ref ImVec2 size_max, ImGuiSizeConstraintCallback custom_callback = null, void* custom_callback_data = null ); // set next window size limits. use -1, -1 on either X/Y axis to preserve the current size. Use callback to apply non-trivial programmatic constraints.
    void            SetNextWindowContentSize( const ref ImVec2 size );                      // set next window content size ( enforce the range of scrollbars ). set axis to 0.0f to leave it automatic. call before Begin()
    void            SetNextWindowContentWidth( float width );                               // set next window content width ( enforce the range of horizontal scrollbar ). call before Begin()
    void            SetNextWindowCollapsed( bool collapsed, ImGuiSetCond cond = 0 );        // set next window collapsed state. call before Begin()
    void            SetNextWindowFocus();                                                   // set next window to be focused / front-most. call before Begin()
    void            SetWindowPos( const ref ImVec2 pos, ImGuiSetCond cond = 0 );            // ( not recommended ) set current window position - call within Begin()/End(). prefer using SetNextWindowPos(), as this may incur tearing and side-effects.
    void            SetWindowSize( const ref ImVec2 size, ImGuiSetCond cond = 0 );          // ( not recommended ) set current window size - call within Begin()/End(). set to ImVec2( 0, 0 ) to force an auto-fit. prefer using SetNextWindowSize(), as this may incur tearing and minor side-effects.
    void            SetWindowCollapsed( bool collapsed, ImGuiSetCond cond = 0 );            // ( not recommended ) set current window collapsed state. prefer using SetNextWindowCollapsed().
    void            SetWindowFocus();                                                       // ( not recommended ) set current window to be focused / front-most. prefer using SetNextWindowFocus().
    void            SetWindowPos( const( char )* name, const ref ImVec2 pos, ImGuiSetCond cond = 0 );      // set named window position.
    void            SetWindowSize( const( char )* name, const ref ImVec2 size, ImGuiSetCond cond = 0 );    // set named window size. set axis to 0.0f to force an auto-fit on this axis.
    void            SetWindowCollapsed( const( char )* name, bool collapsed, ImGuiSetCond cond = 0 );   // set named window collapsed state
    void            SetWindowFocus( const( char )* name );                                              // set named window to be focused / front-most. use null to remove focus.

    float           GetScrollX();                                                           // get scrolling amount [0..GetScrollMaxX()]
    float           GetScrollY();                                                           // get scrolling amount [0..GetScrollMaxY()]
    float           GetScrollMaxX();                                                        // get maximum scrolling amount ~~ ContentSize.X - WindowSize.X
    float           GetScrollMaxY();                                                        // get maximum scrolling amount ~~ ContentSize.Y - WindowSize.Y
    void            SetScrollX( float scroll_x );                                           // set scrolling amount [0..GetScrollMaxX()]
    void            SetScrollY( float scroll_y );                                           // set scrolling amount [0..GetScrollMaxY()]
    void            SetScrollHere( float center_y_ratio = 0.5f );                           // adjust scrolling amount to make current cursor position visible. center_y_ratio=0.0: top, 0.5: center, 1.0: bottom.
    void            SetScrollFromPosY( float pos_y, float center_y_ratio = 0.5f );          // adjust scrolling amount to make given position valid. use GetCursorPos() or GetCursorStartPos()+offset to get valid positions.
    void            SetKeyboardFocusHere( int offset = 0 );                                 // focus keyboard on the next widget. Use positive 'offset' to access sub components of a multiple component widget. Use negative 'offset' to access previous widgets.
    void            SetStateStorage( ImGuiStorage* tree );                                  // replace tree state storage with our own ( if you want to manipulate it yourself, typically clear subsection of it )
    ImGuiStorage*   GetStateStorage();

    // Parameters stacks ( shared )
    void            PushFont( ImFont* font );                                               // use null as a shortcut to push default font
    void            PopFont();
    void            PushStyleColor( ImGuiCol idx, const ref ImVec4 col );
    void            PopStyleColor( int count = 1 );
    void            PushStyleVar( ImGuiStyleVar idx, float val );
    void            PushStyleVar( ImGuiStyleVar idx, const ref ImVec2 val );
    void            PopStyleVar( int count = 1 );
    ImFont*         GetFont();                                                              // get current font
    float           GetFontSize();                                                          // get current font size ( = height in pixels ) of current font with current scale applied
    ImVec2          GetFontTexUvWhitePixel();                                               // get UV coordinate for a while pixel, useful to draw custom shapes via the ImDrawList API
    ImU32           GetColorU32( ImGuiCol idx, float alpha_mul = 1.0f );                    // retrieve given style color with style alpha applied and optional extra alpha multiplier
    ImU32           GetColorU32( const ref ImVec4 col );                                    // retrieve given color with style alpha applied

    // Parameters stacks ( current window )
    void            PushItemWidth( float item_width );                                      // width of items for the common item+label case, pixels. 0.0f = default to ~2/3 of windows width, >0.0f: width in pixels, <0.0f align xx pixels to the right of window ( so -1.0f always align width to the right side )
    void            PopItemWidth();
    float           CalcItemWidth();                                                        // width of item given pushed settings and current cursor position
    void            PushTextWrapPos( float wrap_pos_x = 0.0f );                             // word-wrapping for Text*() commands. < 0.0f: no wrapping; 0.0f: wrap to end of window ( or column ); > 0.0f: wrap at 'wrap_pos_x' position in window local space
    void            PopTextWrapPos();
    void            PushAllowKeyboardFocus( bool v );                                       // allow focusing using TAB/Shift-TAB, enabled by default but you can disable it for certain widgets
    void            PopAllowKeyboardFocus();
    void            PushButtonRepeat( bool repeat );                                        // in 'repeat' mode, Button*() functions return repeated true in a typematic manner ( uses io.KeyRepeatDelay/io.KeyRepeatRate for now ). Note that you can call IsItemActive() after any Button() to tell if the button is held in the current frame.
    void            PopButtonRepeat();

    // Cursor / Layout
    void            Separator();                                                            // horizontal line
    void            SameLine( float pos_x = 0.0f, float spacing_w = -1.0f );                // call between widgets or groups to layout them horizontally
    void            NewLine();                                                              // undo a SameLine()
    void            Spacing();                                                              // add vertical spacing
    void            Dummy( const ref ImVec2 size );                                         // add a dummy item of given size
    void            Indent( float indent_w = 0.0f );                                        // move content position toward the right, by style.IndentSpacing or indent_w if >0
    void            Unindent( float indent_w = 0.0f );                                      // move content position back to the left, by style.IndentSpacing or indent_w if >0
    void            BeginGroup();                                                           // lock horizontal starting position + capture group bounding box into one "item" ( so you can use IsItemHovered() or layout primitives such as SameLine() on whole group, etc. )
    void            EndGroup();
    ImVec2          GetCursorPos();                                                         // cursor position is relative to window position
    float           GetCursorPosX();                                                        // "
    float           GetCursorPosY();                                                        // "
    void            SetCursorPos( const ref ImVec2 local_pos );                             // "
    void            SetCursorPosX( float x );                                               // "
    void            SetCursorPosY( float y );                                               // "
    ImVec2          GetCursorStartPos();                                                    // initial cursor position
    ImVec2          GetCursorScreenPos();                                                   // cursor position in absolute screen coordinates [0..io.DisplaySize] ( useful to work with ImDrawList API )
    void            SetCursorScreenPos( const ref ImVec2 pos );                             // cursor position in absolute screen coordinates [0..io.DisplaySize]
    void            AlignFirstTextHeightToWidgets();                                        // call once if the first item on the line is a Text() item and you want to vertically lower it to match subsequent ( bigger ) widgets
    float           GetTextLineHeight();                                                    // height of font == GetWindowFontSize()
    float           GetTextLineHeightWithSpacing();                                         // distance ( in pixels ) between 2 consecutive lines of text == GetWindowFontSize() + GetStyle().ItemSpacing.y
    float           GetItemsLineHeightWithSpacing();                                        // distance ( in pixels ) between 2 consecutive lines of standard height widgets == GetWindowFontSize() + GetStyle().FramePadding.y*2 + GetStyle().ItemSpacing.y

    // Columns
    // You can also use SameLine( pos_x ) for simplified columning. The columns API is still work-in-progress and rather lacking.
    void            Columns( int count = 1, const( char )* id = null, bool border = true );    // setup number of columns. use an identifier to distinguish multiple column sets. close with Columns( 1 ).
    void            NextColumn();                                                           // next column
    int             GetColumnIndex();                                                       // get current column index
    float           GetColumnOffset( int column_index = -1 );                               // get position of column line ( in pixels, from the left side of the contents region ). pass -1 to use current column, otherwise 0..GetcolumnsCount() inclusive. column 0 is usually 0.0f and not resizable unless you call this
    void            SetColumnOffset( int column_index, float offset_x );                    // set position of column line ( in pixels, from the left side of the contents region ). pass -1 to use current column
    float           GetColumnWidth( int column_index = -1 );                                // column width ( == GetColumnOffset( GetColumnIndex()+1 ) - GetColumnOffset( GetColumnOffset())
    int             GetColumnsCount();                                                      // number of columns ( what was passed to Columns())

    // ID scopes
    // If you are creating widgets in a loop you most likely want to push a unique identifier so ImGui can differentiate them.
    // You can also use the "##foobar" syntax within widget label to distinguish them from each others. Read "A primer on the use of labels/IDs" in the FAQ for more details.
    void            PushID( const( char )* str_id );                                           // push identifier into the ID stack. IDs are hash of the *entire* stack!
    void            PushID( const( char )* str_id_begin, const( char )* str_id_end );
    void            PushID( const void* ptr_id );
    void            PushID( int int_id );
    void            PopID();
    ImGuiID         GetID( const( char )* str_id );                                            // calculate unique ID ( hash of whole ID stack + given parameter ). useful if you want to query into ImGuiStorage yourself. otherwise rarely needed
    ImGuiID         GetID( const( char )* str_id_begin, const( char )* str_id_end );
    ImGuiID         GetID( const void* ptr_id );

    // Widgets
    void            Text( const( char )* fmt, ... );   // IM_PRINTFARGS( 1 );
    void            TextV( const( char )* fmt, va_list args );
    void            TextColored( const ref ImVec4 col, const( char )* fmt, ... );  // IM_PRINTFARGS( 2 );   // shortcut for PushStyleColor( ImGuiCol_Text, col ); Text( fmt, ... ); PopStyleColor();
    void            TextColoredV( const ref ImVec4 col, const( char )* fmt, va_list args );
    void            TextDisabled( const( char )* fmt, ... );   // IM_PRINTFARGS( 1 );                       // shortcut for PushStyleColor( ImGuiCol_Text, style.Colors[ImGuiCol_TextDisabled] ); Text( fmt, ... ); PopStyleColor();
    void            TextDisabledV( const( char )* fmt, va_list args );
    void            TextWrapped( const( char )* fmt, ... );    // IM_PRINTFARGS( 1 );                       // shortcut for PushTextWrapPos( 0.0f ); Text( fmt, ... ); PopTextWrapPos();. Note that this won't work on an auto-resizing window if there's no other widgets to extend the window width, yoy may need to set a size using SetNextWindowSize().
    void            TextWrappedV( const( char )* fmt, va_list args );
    void            TextUnformatted( const( char )* text, const( char )* text_end = null );                 // doesn't require null terminated string if 'text_end' is specified. no copy done to any bounded stack buffer, recommended for long chunks of text
    void            LabelText( const( char )* label, const( char )* fmt, ... );   // IM_PRINTFARGS( 2 );    // display text+label aligned the same way as value+label widgets
    void            LabelTextV( const( char )* label, const( char )* fmt, va_list args );
    void            Bullet();                                                                   // draw a small circle and keep the cursor on the same line. advance cursor x position by GetTreeNodeToLabelSpacing(), same distance that TreeNode() uses
    void            BulletText( const( char )* fmt, ... ); // IM_PRINTFARGS( 1 );               // shortcut for Bullet()+Text()
    void            BulletTextV( const( char )* fmt, va_list args );
    bool            Button( const( char )* label, const ref ImVec2 size );                      // button, original param const ref ImVec2 size = ImVec2( 0, 0 ) not possible
    bool            Button( const( char )* label ) { ImVec2 size; return Button( label, size ); }  // button, emulating original behaviour
    bool            SmallButton( const( char )* label );                                        // button with FramePadding=( 0, 0 )
    bool            InvisibleButton( const( char )* str_id, const ref ImVec2 size );

    void            Image( ImTextureID user_texture_id, const ref ImVec2 size, const ref ImVec2 uv0,        const ref ImVec2 uv1,        const ref ImVec4 tint_col,              const ref ImVec4 border_col );
    void            Image( ImTextureID user_texture_id, const ref ImVec2 size, const ref ImVec2 uv0,        const ref ImVec2 uv1,        const ref ImVec4 tint_col ) {                     ImVec4 border_col = ImVec4( 0, 0, 0, 0 ); Image( user_texture_id, size, uv0, uv1, tint_col, border_col ); }
    void            Image( ImTextureID user_texture_id, const ref ImVec2 size, const ref ImVec2 uv0,        const ref ImVec2 uv1 ) {               ImVec4 tint_col = ImVec4( 1, 1, 1, 1 ); ImVec4 border_col = ImVec4( 0, 0, 0, 0 ); Image( user_texture_id, size, uv0, uv1, tint_col, border_col ); }
    void            Image( ImTextureID user_texture_id, const ref ImVec2 size, const ref ImVec2 uv0 ) {               ImVec2 uv1 = ImVec2( 1, 1 ); ImVec4 tint_col = ImVec4( 1, 1, 1, 1 ); ImVec4 border_col = ImVec4( 0, 0, 0, 0 ); Image( user_texture_id, size, uv0, uv1, tint_col, border_col ); }
    void            Image( ImTextureID user_texture_id, const ref ImVec2 size ) {        ImVec2 uv0 = ImVec2( 0, 0 ); ImVec2 uv1 = ImVec2( 1, 1 ); ImVec4 tint_col = ImVec4( 1, 1, 1, 1 ); ImVec4 border_col = ImVec4( 0, 0, 0, 0 ); Image( user_texture_id, size, uv0, uv1, tint_col, border_col ); }

    bool            ImageButton( ImTextureID user_texture_id, const ref ImVec2 size, const ref ImVec2 uv0,        const ref ImVec2 uv1, int frame_padding, const ref ImVec4 bg_col,              const ref ImVec4 tint_col );    // < 0 frame_padding uses default frame padding settings. 0 for no padding
    bool            ImageButton( ImTextureID user_texture_id, const ref ImVec2 size, const ref ImVec2 uv0,        const ref ImVec2 uv1, int frame_padding, const ref ImVec4 bg_col ) {                     ImVec4 tint_col = ImVec4( 1, 1, 1, 1 ); return ImageButton( user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col ); }
    bool            ImageButton( ImTextureID user_texture_id, const ref ImVec2 size, const ref ImVec2 uv0,        const ref ImVec2 uv1, int frame_padding = -1 ) {   ImVec4 bg_col = ImVec4( 0, 0, 0, 0 ); ImVec4 tint_col = ImVec4( 1, 1, 1, 1 ); return ImageButton( user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col ); }
    bool            ImageButton( ImTextureID user_texture_id, const ref ImVec2 size, const ref ImVec2 uv0 ) {               ImVec2 uv1 = ImVec2( 1, 1 );             ImVec4 bg_col = ImVec4( 0, 0, 0, 0 ); ImVec4 tint_col = ImVec4( 1, 1, 1, 1 ); return ImageButton( user_texture_id, size, uv0, uv1,            -1, bg_col, tint_col ); }
    bool            ImageButton( ImTextureID user_texture_id, const ref ImVec2 size ) {        ImVec2 uv0 = ImVec2( 0, 0 ); ImVec2 uv1 = ImVec2( 1, 1 );             ImVec4 bg_col = ImVec4( 0, 0, 0, 0 ); ImVec4 tint_col = ImVec4( 1, 1, 1, 1 ); return ImageButton( user_texture_id, size, uv0, uv1,            -1, bg_col, tint_col ); }

    bool            Checkbox( const( char )* label, bool* v );
    bool            CheckboxFlags( const( char )* label, uint* flags, uint flags_value );
    bool            RadioButton( const( char )* label, bool active );
    bool            RadioButton( const( char )* label, int* v, int v_button );
    bool            Combo( const( char )* label, int* current_item, const( char )* items, int items_count, int height_in_items = -1 );
    bool            Combo( const( char )* label, int* current_item, const( char )* items_separated_by_zeros, int height_in_items = -1 );      // separate items with \0, end item-list with \0\0
    bool            Combo( const( char )* label, int* current_item, bool function(void* data, int idx, const(char*)* out_text) items_getter, void* data, int items_count, int height_in_items = -1 );
    bool            ColorButton( const ref ImVec4 col, bool small_height = false, bool outline_border = true );
    pragma( mangle, "?ColorEdit3@ImGui@@YA_NPEBDQEAM@Z" )       bool ColorEdit3( const( char )* label, ref float[3] col );  // Hint: 'float col[3]' function argument is same as 'float* col'. You can pass address of first element out of a contiguous set, e.ref g. myvector.x
    pragma( mangle, "?ColorEdit3@ImGui@@YA_NPEBDQEAM@Z" )       bool ColorEdit3( const( char )* label,     float*   col );  // Hint: 'float col[3]' function argument is same as 'float* col'. You can pass address of first element out of a contiguous set, e.ref g. myvector.x
    pragma( mangle, "?ColorEdit4@ImGui@@YA_NPEBDQEAM_N@Z" )     bool ColorEdit4( const( char )* label, ref float[4] col );  // "
    pragma( mangle, "?ColorEdit4@ImGui@@YA_NPEBDQEAM_N@Z" )     bool ColorEdit4( const( char )* label,     float*   col );  // "
    bool            ColorEdit4( const( char )* label, float[4] col, bool show_alpha = true );    // "
    void            ColorEditMode( ImGuiColorEditMode mode );                                 // FIXME-OBSOLETE: This is inconsistent with most of the API and will be obsoleted/replaced.
    void            PlotLines( const( char )* label, const float* values, int values_count, int values_offset = 0, const( char )* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2( 0, 0 ), int stride = size_t.sizeof ); // sizeof( float ));
    void            PlotLines( const( char )* label, float function(void* data, int idx) values_getter, void* data, int values_count, int values_offset = 0, const( char )* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2( 0, 0 ));
    void            PlotHistogram( const( char )* label, const float* values, int values_count, int values_offset = 0, const( char )* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2( 0, 0 ), int stride = size_t.sizeof ); // sizeof( float ));
    void            PlotHistogram( const( char )* label, float function( void* data, int idx ) values_getter, void* data, int values_count, int values_offset = 0, const( char )* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2( 0, 0 ));
    void            ProgressBar( float fraction, const ref ImVec2 size_arg, const( char )* overlay = null );
    void            ProgressBar( float fraction ) {        ImVec2 size_arg = ImVec2( -1, 0 ); ProgressBar( fraction, size_arg ); }

    // Widgets: Drags ( tip: ctrl+click on a drag box to input with keyboard. manually input values aren't clamped, can go off-bounds )
    // For all the Float2/Float3/Float4/Int2/Int3/Int4 versions of every functions, remember than a 'float[3] v' function argument is the same as 'float* v'. You can pass address of your first element out of a contiguous set, e.ref g. myvector.x
    pragma( mangle, "?DragFloat@ImGui@@YA_NPEBDPEAMMMM0M@Z" )   bool DragFloat(  const( char )* label, ref float    v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", float power = 1.0f );     // If v_min >= v_max we have no bound
    pragma( mangle, "?DragFloat@ImGui@@YA_NPEBDPEAMMMM0M@Z" )   bool DragFloat(  const( char )* label,     float*   v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", float power = 1.0f );     // "
    pragma( mangle, "?DragFloat2@ImGui@@YA_NPEBDQEAMMMM0M@Z" )  bool DragFloat2( const( char )* label, ref float[2] v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?DragFloat2@ImGui@@YA_NPEBDQEAMMMM0M@Z" )  bool DragFloat2( const( char )* label,     float*   v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?DragFloat3@ImGui@@YA_NPEBDQEAMMMM0M@Z" )  bool DragFloat3( const( char )* label, ref float[3] v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?DragFloat3@ImGui@@YA_NPEBDQEAMMMM0M@Z" )  bool DragFloat3( const( char )* label,     float*   v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?DragFloat4@ImGui@@YA_NPEBDQEAMMMM0M@Z" )  bool DragFloat4( const( char )* label, ref float[4] v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?DragFloat4@ImGui@@YA_NPEBDQEAMMMM0M@Z" )  bool DragFloat4( const( char )* label,     float*   v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", float power = 1.0f );

    pragma( mangle, "?DragFloatRange2@ImGui@@YA_NPEBDPEAM1MMM00M@Z" )   bool DragFloatRange2( const( char )* label, ref float  v_current_min, ref float  v_current_max, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", const( char )* display_format_max = null, float power = 1.0f );
    pragma( mangle, "?DragFloatRange2@ImGui@@YA_NPEBDPEAM1MMM00M@Z" )   bool DragFloatRange2( const( char )* label,     float* v_current_min,     float* v_current_max, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const( char )* display_format = "%.3f", const( char )* display_format_max = null, float power = 1.0f );

    pragma( mangle, "?DragInt@ImGui@@YA_NPEBDPEAHMHH0@Z" )      bool DragInt(  const( char )* label, ref int    v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f" );    // If v_min >= v_max we have no bound
    pragma( mangle, "?DragInt@ImGui@@YA_NPEBDPEAHMHH0@Z" )      bool DragInt(  const( char )* label,     int*   v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f" );
    pragma( mangle, "?DragInt2@ImGui@@YA_NPEBDQEAHMHH0@Z" )     bool DragInt2( const( char )* label, ref int[2] v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f" );
    pragma( mangle, "?DragInt2@ImGui@@YA_NPEBDQEAHMHH0@Z" )     bool DragInt2( const( char )* label,     int*   v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f" );
    pragma( mangle, "?DragInt3@ImGui@@YA_NPEBDQEAHMHH0@Z" )     bool DragInt3( const( char )* label, ref int[3] v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f" );
    pragma( mangle, "?DragInt3@ImGui@@YA_NPEBDQEAHMHH0@Z" )     bool DragInt3( const( char )* label,     int*   v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f" );
    pragma( mangle, "?DragInt4@ImGui@@YA_NPEBDQEAHMHH0@Z" )     bool DragInt4( const( char )* label, ref int[4] v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f" );
    pragma( mangle, "?DragInt4@ImGui@@YA_NPEBDQEAHMHH0@Z" )     bool DragInt4( const( char )* label,     int*   v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f" );

    pragma( mangle, "?DragIntRange2@ImGui@@YA_NPEBDPEAH1MHH00@Z" )  bool DragIntRange2( const( char )* label, ref int  v_current_min, ref int  v_current_max, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f", const( char )* display_format_max = null );
    pragma( mangle, "?DragIntRange2@ImGui@@YA_NPEBDPEAH1MHH00@Z" )  bool DragIntRange2( const( char )* label,     int* v_current_min,     int* v_current_max, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const( char )* display_format = "%.0f", const( char )* display_format_max = null );

    // Widgets: Input with Keyboard
    bool            InputText( const( char )* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags = 0, ImGuiTextEditCallback callback = null, void* user_data = null );
    bool            InputTextMultiline( const( char )* label, char* buf, size_t buf_size, const ref ImVec2 size, ImGuiInputTextFlags flags = 0, ImGuiTextEditCallback callback = null, void* user_data = null );
    bool            InputTextMultiline( const( char )* label, char* buf, size_t buf_size ) {        ImVec2 size = ImVec2( 0, 0 ); return InputTextMultiline( label, buf, buf_size, size ); }

    pragma( mangle, "?InputFloat@ImGui@@YA_NPEBDPEAMMMHH@Z" )   bool InputFloat(  const( char )* label, ref float    v, float step = 0.0f, float step_fast = 0.0f, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputFloat@ImGui@@YA_NPEBDPEAMMMHH@Z" )   bool InputFloat(  const( char )* label,     float*   v, float step = 0.0f, float step_fast = 0.0f, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputFloat2@ImGui@@YA_NPEBDQEAMHH@Z" )    bool InputFloat2( const( char )* label, ref float[2] v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputFloat2@ImGui@@YA_NPEBDQEAMHH@Z" )    bool InputFloat2( const( char )* label,     float*   v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputFloat3@ImGui@@YA_NPEBDQEAMHH@Z" )    bool InputFloat3( const( char )* label, ref float[3] v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputFloat3@ImGui@@YA_NPEBDQEAMHH@Z" )    bool InputFloat3( const( char )* label,     float*   v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputFloat4@ImGui@@YA_NPEBDQEAMHH@Z" )    bool InputFloat4( const( char )* label, ref float[4] v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputFloat4@ImGui@@YA_NPEBDQEAMHH@Z" )    bool InputFloat4( const( char )* label,     float*   v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0 );

    pragma( mangle, "?InputInt@ImGui@@YA_NPEBDPEAHHHH@Z" )      bool InputInt(  const( char )* label, ref int    v, int step = 1, int step_fast = 100, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputInt@ImGui@@YA_NPEBDPEAHHHH@Z" )      bool InputInt(  const( char )* label,     int*   v, int step = 1, int step_fast = 100, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputInt2@ImGui@@YA_NPEBDQEAHH@Z" )       bool InputInt2( const( char )* label, ref int[2] v, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputInt2@ImGui@@YA_NPEBDQEAHH@Z" )       bool InputInt2( const( char )* label,     int*   v, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputInt3@ImGui@@YA_NPEBDQEAHH@Z" )       bool InputInt3( const( char )* label, ref int[3] v, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputInt3@ImGui@@YA_NPEBDQEAHH@Z" )       bool InputInt3( const( char )* label,     int*   v, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputInt4@ImGui@@YA_NPEBDQEAHH@Z" )       bool InputInt4( const( char )* label, ref int[4] v, ImGuiInputTextFlags extra_flags = 0 );
    pragma( mangle, "?InputInt4@ImGui@@YA_NPEBDQEAHH@Z" )       bool InputInt4( const( char )* label,     int*   v, ImGuiInputTextFlags extra_flags = 0 );

    // Widgets: Sliders ( tip: ctrl+click on a slider to input with keyboard. manually input values aren't clamped, can go off-bounds )
    pragma( mangle, "?SliderFloat@ImGui@@YA_NPEBDPEAMMM0M@Z" )  bool SliderFloat(  const( char )* label, ref float    v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?SliderFloat@ImGui@@YA_NPEBDPEAMMM0M@Z" )  bool SliderFloat(  const( char )* label,     float*   v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?SliderFloat2@ImGui@@YA_NPEBDQEAMMM0M@Z" ) bool SliderFloat2( const( char )* label, ref float[2] v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?SliderFloat2@ImGui@@YA_NPEBDQEAMMM0M@Z" ) bool SliderFloat2( const( char )* label,     float*   v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?SliderFloat3@ImGui@@YA_NPEBDQEAMMM0M@Z" ) bool SliderFloat3( const( char )* label, ref float[3] v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?SliderFloat3@ImGui@@YA_NPEBDQEAMMM0M@Z" ) bool SliderFloat3( const( char )* label,     float*   v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?SliderFloat4@ImGui@@YA_NPEBDQEAMMM0M@Z" ) bool SliderFloat4( const( char )* label, ref float[4] v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?SliderFloat4@ImGui@@YA_NPEBDQEAMMM0M@Z" ) bool SliderFloat4( const( char )* label,     float*   v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );

    pragma( mangle, "?SliderAngle@ImGui@@YA_NPEBDPEAMMM@Z" )    bool SliderAngle(  const( char )* label, ref float    v_rad, float v_degrees_min = -360.0f, float v_degrees_max = +360.0f );
    pragma( mangle, "?SliderAngle@ImGui@@YA_NPEBDPEAMMM@Z" )    bool SliderAngle(  const( char )* label,     float*   v_rad, float v_degrees_min = -360.0f, float v_degrees_max = +360.0f );

    pragma( mangle, "?SliderInt@ImGui@@YA_NPEBDPEAHHH0@Z" )     bool SliderInt(  const( char )* label, ref int    v, int v_min, int v_max, const( char )* display_format = "%.0f" );
    pragma( mangle, "?SliderInt@ImGui@@YA_NPEBDPEAHHH0@Z" )     bool SliderInt(  const( char )* label,     int*   v, int v_min, int v_max, const( char )* display_format = "%.0f" );
    pragma( mangle, "?SliderInt2@ImGui@@YA_NPEBDQEAHHH0@Z" )    bool SliderInt2( const( char )* label, ref int[2] v, int v_min, int v_max, const( char )* display_format = "%.0f" );
    pragma( mangle, "?SliderInt2@ImGui@@YA_NPEBDQEAHHH0@Z" )    bool SliderInt2( const( char )* label,     int*   v, int v_min, int v_max, const( char )* display_format = "%.0f" );
    pragma( mangle, "?SliderInt3@ImGui@@YA_NPEBDQEAHHH0@Z" )    bool SliderInt3( const( char )* label, ref int[3] v, int v_min, int v_max, const( char )* display_format = "%.0f" );
    pragma( mangle, "?SliderInt3@ImGui@@YA_NPEBDQEAHHH0@Z" )    bool SliderInt3( const( char )* label,     int*   v, int v_min, int v_max, const( char )* display_format = "%.0f" );
    pragma( mangle, "?SliderInt4@ImGui@@YA_NPEBDQEAHHH0@Z" )    bool SliderInt4( const( char )* label, ref int[4] v, int v_min, int v_max, const( char )* display_format = "%.0f" );
    pragma( mangle, "?SliderInt4@ImGui@@YA_NPEBDQEAHHH0@Z" )    bool SliderInt4( const( char )* label,     int*   v, int v_min, int v_max, const( char )* display_format = "%.0f" );

    pragma( mangle, "?VSliderFloat@ImGui@@YA_NPEBDAEBUImVec2@@PEAMMM0M@Z" ) bool VSliderFloat( const( char )* label, const ref ImVec2 size, ref float  v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );
    pragma( mangle, "?VSliderFloat@ImGui@@YA_NPEBDAEBUImVec2@@PEAMMM0M@Z" ) bool VSliderFloat( const( char )* label, const ref ImVec2 size,     float* v, float v_min, float v_max, const( char )* display_format = "%.3f", float power = 1.0f );

    pragma( mangle, "?VSliderInt@ImGui@@YA_NPEBDAEBUImVec2@@PEAHHH0@Z" )    bool VSliderInt( const( char )* label, const ref ImVec2 size, ref int  v, int v_min, int v_max, const( char )* display_format = "%.0f" );
    pragma( mangle, "?VSliderInt@ImGui@@YA_NPEBDAEBUImVec2@@PEAHHH0@Z" )    bool VSliderInt( const( char )* label, const ref ImVec2 size,     int* v, int v_min, int v_max, const( char )* display_format = "%.0f" );

    // Widgets: Trees
    bool            TreeNode( const( char )* label );                                          // if returning 'true' the node is open and the tree id is pushed into the id stack. user is responsible for calling TreePop().
    bool            TreeNode( const( char )* str_id, const( char )* fmt, ... );                   // IM_PRINTFARGS( 2 );    // read the FAQ about why and how to use ID. to align arbitrary text at the same level as a TreeNode() you can use Bullet().
    bool            TreeNode( const void* ptr_id, const( char )* fmt, ... );                   // IM_PRINTFARGS( 2 );    // "
    bool            TreeNodeV( const( char )* str_id, const( char )* fmt, va_list args );         // "
    bool            TreeNodeV( const void* ptr_id, const( char )* fmt, va_list args );         // "
//  bool            TreeNodeEx( const( char )* label, ImGuiTreeNodeFlags flags = 0 );
//  bool            TreeNodeEx( const( char )* str_id, ImGuiTreeNodeFlags flags, const( char )* fmt, ... );   // IM_PRINTFARGS( 3 );
//  bool            TreeNodeEx( const void* ptr_id, ImGuiTreeNodeFlags flags, const( char )* fmt, ... );   // IM_PRINTFARGS( 3 );
//  bool            TreeNodeExV( const( char )* str_id, ImGuiTreeNodeFlags flags, const( char )* fmt, va_list args );
//  bool            TreeNodeExV( const void* ptr_id, ImGuiTreeNodeFlags flags, const( char )* fmt, va_list args );
    void            TreePush( const( char )* str_id = null );                                  // ~ Indent()+PushId(). Already called by TreeNode() when returning true, but you can call Push/Pop yourself for layout purpose
    void            TreePush( const void* ptr_id = null );                                  // "
    void            TreePop();                                                              // ~ Unindent()+PopId()
    void            TreeAdvanceToLabelPos();                                                // advance cursor x position by GetTreeNodeToLabelSpacing()
    float           GetTreeNodeToLabelSpacing();                                            // horizontal distance preceding label when using TreeNode*() or Bullet() == ( g.FontSize + style.FramePadding.x*2 ) for a regular unframed TreeNode
    void            SetNextTreeNodeOpen( bool is_open, ImGuiSetCond cond = 0 );             // set next TreeNode/CollapsingHeader open state.
    bool            CollapsingHeader( const( char )* label, ImGuiTreeNodeFlags flags = 0 );    // if returning 'true' the header is open. doesn't indent nor push on ID stack. user doesn't have to call TreePop().
    bool            CollapsingHeader( const( char )* label, bool* p_open, ImGuiTreeNodeFlags flags = 0 ); // when 'p_open' isn't null, display an additional small close button on upper right of the header

    // Widgets: Selectable / Lists
    bool            Selectable( const( char )* label, bool selected,         ImGuiSelectableFlags flags,  const ref ImVec2 size );  // size.x==0.0: use remaining width, size.x>0.0: specify width. size.y==0.0: use label height, size.y>0.0: specify height
    bool            Selectable( const( char )* label, bool selected = false, ImGuiSelectableFlags flags = 0 ) {     ImVec2 size = ImVec2( 0, 0 ); return Selectable( label,   selected, flags, size ); }  // size.x==0.0: use remaining width, size.x>0.0: specify width. size.y==0.0: use label height, size.y>0.0: specify height
    bool            Selectable( const( char )* label, bool* p_selected,      ImGuiSelectableFlags flags,  const ref ImVec2 size );
    bool            Selectable( const( char )* label, bool* p_selected,      ImGuiSelectableFlags flags = 0 ) {     ImVec2 size = ImVec2( 0, 0 ); return Selectable( label, p_selected, flags, size ); }
    bool            ListBox( const( char )* label, int* current_item, const( char )** items, int items_count, int height_in_items = -1 );
    bool            ListBox( const( char )* label, int* current_item, bool function( void* data, int idx, const( char* )* out_text ) items_getter, void* data, int items_count, int height_in_items = -1 );
    bool            ListBoxHeader( const( char )* label, const ref ImVec2 size ); // use if you want to reimplement ListBox() will custom data or interactions. make sure to call ListBoxFooter() afterwards.
    bool            ListBoxHeader( const( char )* label ) {        ImVec2 size = ImVec2( 0, 0 ); return ListBoxHeader( label, size ); }
    bool            ListBoxHeader( const( char )* label, int items_count, int height_in_items = -1 ); // "
    void            ListBoxFooter();                                                        // terminate the scrolling region

    // Widgets: Value() Helpers. Output single value in "name: value" format ( tip: freely declare more in your code to handle your types. you can add functions to the ImGui namespace )
    void            Value( const( char )* prefix, bool b );
    void            Value( const( char )* prefix, int v );
    void            Value( const( char )* prefix, uint v );
    void            Value( const( char )* prefix, float v, const( char )* float_format = null );
    void            ValueColor( const( char )* prefix, const ref ImVec4 v );
    void            ValueColor( const( char )* prefix, ImU32 v );

    // Tooltips
    void            SetTooltip( const( char )* fmt, ... ); // IM_PRINTFARGS( 1 );              // set tooltip under mouse-cursor, typically use with ImGui::IsHovered(). last call wins
    void            SetTooltipV( const( char )* fmt, va_list args );
    void            BeginTooltip();                                                         // use to create full-featured tooltip windows that aren't just text
    void            EndTooltip();

    // Menus
    bool            BeginMainMenuBar();                                                     // create and append to a full screen menu-bar. only call EndMainMenuBar() if this returns true!
    void            EndMainMenuBar();
    bool            BeginMenuBar();                                                         // append to menu-bar of current window ( requires ImGuiWindowFlags_MenuBar flag set ). only call EndMenuBar() if this returns true!
    void            EndMenuBar();
    bool            BeginMenu( const( char )* label, bool enabled = true );                    // create a sub-menu entry. only call EndMenu() if this returns true!
    void            EndMenu();
    bool            MenuItem( const( char )* label, const( char )* shortcut = null, bool selected = false, bool enabled = true );  // return true when activated. shortcuts are displayed for convenience but not processed by ImGui at the moment
    bool            MenuItem( const( char )* label, const( char )* shortcut, bool* p_selected, bool enabled = true );              // return true when activated + toggle ( *p_selected ) if p_selected != null

    // Popups
    void            OpenPopup( const( char )* str_id );                                        // mark popup as open. popups are closed when user click outside, or activate a pressable item, or CloseCurrentPopup() is called within a BeginPopup()/EndPopup() block. popup identifiers are relative to the current ID-stack ( so OpenPopup and BeginPopup needs to be at the same level ).
    bool            BeginPopup( const( char )* str_id );                                       // return true if the popup is open, and you can start outputting to it. only call EndPopup() if BeginPopup() returned true!
    bool            BeginPopupModal( const( char )* name, bool* p_open = null, ImGuiWindowFlags extra_flags = 0 );               // modal dialog ( block interactions behind the modal window, can't close the modal window by clicking outside )
    bool            BeginPopupContextItem( const( char )* str_id, int mouse_button = 1 );                                        // helper to open and begin popup when clicked on last item. read comments in .cpp!
    bool            BeginPopupContextWindow( bool also_over_items = true, const( char )* str_id = null, int mouse_button = 1 );  // helper to open and begin popup when clicked on current window.
    bool            BeginPopupContextVoid( const( char )* str_id = null, int mouse_button = 1 );                                 // helper to open and begin popup when clicked in void ( no window ).
    void            EndPopup();
    void            CloseCurrentPopup();                                                    // close the popup we have begin-ed into. clicking on a MenuItem or Selectable automatically close the current popup.

    // Logging: all text output from interface is redirected to tty/file/clipboard. By default, tree nodes are automatically opened during logging.
    void            LogToTTY( int max_depth = -1 );                                         // start logging to tty
    void            LogToFile( int max_depth = -1, const( char )* filename = null );           // start logging to file
    void            LogToClipboard( int max_depth = -1 );                                   // start logging to OS clipboard
    void            LogFinish();                                                            // stop logging ( close file, etc. )
    void            LogButtons();                                                           // helper to display buttons for logging to tty/file/clipboard
    void            LogText( const( char )* fmt, ... );    // IM_PRINTFARGS( 1 );              // pass text data straight to log ( without being displayed )

    // Clipping
    void            PushClipRect( const ref ImVec2 clip_rect_min, const ref ImVec2 clip_rect_max, bool intersect_with_current_clip_rect );
    void            PopClipRect();

    // Utilities
    bool            IsItemHovered();                                                        // was the last item hovered by mouse?
    bool            IsItemHoveredRect();                                                    // was the last item hovered by mouse? even if another item is active or window is blocked by popup while we are hovering this
    bool            IsItemActive();                                                         // was the last item active? ( e.g. button being held, text field being edited- items that don't interact will always return false )
    bool            IsItemClicked( int mouse_button = 0 );                                  // was the last item clicked? ( e.g. button/node just clicked on )
    bool            IsItemVisible();                                                        // was the last item visible? ( aka not out of sight due to clipping/scrolling. )
    bool            IsAnyItemHovered();
    bool            IsAnyItemActive();
    ImVec2          GetItemRectMin();                                                       // get bounding rect of last item in screen space
    ImVec2          GetItemRectMax();                                                       // "
    ImVec2          GetItemRectSize();                                                      // "
    void            SetItemAllowOverlap();                                                  // allow last item to be overlapped by a subsequent item. sometimes useful with invisible buttons, selectables, etc. to catch unused area.
    bool            IsWindowHovered();                                                      // is current window hovered and hoverable ( not blocked by a popup ) ( differentiate child windows from each others )
    bool            IsWindowFocused();                                                      // is current window focused
    bool            IsRootWindowFocused();                                                  // is current root window focused ( root = top-most parent of a child, otherwise self )
    bool            IsRootWindowOrAnyChildFocused();                                        // is current root window or any of its child ( including current window ) focused
    bool            IsRootWindowOrAnyChildHovered();                                        // is current root window or any of its child ( including current window ) hovered and hoverable ( not blocked by a popup )
    bool            IsRectVisible( const ref ImVec2 size );                                 // test if rectangle ( of given size, starting from cursor position ) is visible / not clipped.
    bool            IsRectVisible( const ref ImVec2 rect_min, const ref ImVec2 rect_max );  // test if rectangle ( in screen space ) is visible / not clipped. to perform coarse clipping on user's side.
    bool            IsPosHoveringAnyWindow( const ref ImVec2 pos );                         // is given position hovering any active imgui window
    float           GetTime();
    int             GetFrameCount();
    const( char )*     GetStyleColName( ImGuiCol idx );
    ImVec2          CalcItemRectClosestPoint( const ref ImVec2 pos, bool on_edge = false, float outward = +0.0f );   // utility to find the closest point the last item bounding rectangle edge. useful to visually link items
    ImVec2          CalcTextSize( const( char )* text, const( char )* text_end = null, bool hide_text_after_double_hash = false, float wrap_width = -1.0f );
    void            CalcListClipping( int items_count, float items_height, int* out_items_display_start, int* out_items_display_end );    // calculate coarse clipping for large list of evenly sized items. Prefer using the ImGuiListClipper higher-level helper if you can.

    bool            BeginChildFrame( ImGuiID id, const ref ImVec2 size, ImGuiWindowFlags extra_flags = 0 );  // helper to create a child window / scrolling region that looks like a normal widget frame
    void            EndChildFrame();

    ImVec4          ColorConvertU32ToFloat4( ImU32 val );
    ImU32           ColorConvertFloat4ToU32( const ref ImVec4 vec );
    void            ColorConvertRGBtoHSV( float r, float g, float b, ref float out_h, ref float out_s, ref float out_v );
    void            ColorConvertHSVtoRGB( float h, float s, float v, ref float out_r, ref float out_g, ref float out_b );

    // Inputs
    int             GetKeyIndex( ImGuiKey key );                                            // map ImGuiKey_* values into user's key index. == io.KeyMap[key]
    bool            IsKeyDown( int key_index );                                             // key_index into the keys_down[] array, imgui doesn't know the semantic of each entry, uses your own indices!
    bool            IsKeyPressed( int key_index, bool repeat = true );                      // uses user's key indices as stored in the keys_down[] array. if repeat=true. uses io.KeyRepeatDelay / KeyRepeatRate
    bool            IsKeyReleased( int key_index );                                         // "
    bool            IsMouseDown( int button );                                              // is mouse button held
    bool            IsMouseClicked( int button, bool repeat = false );                      // did mouse button clicked ( went from !Down to Down )
    bool            IsMouseDoubleClicked( int button );                                     // did mouse button double-clicked. a double-click returns false in IsMouseClicked(). uses io.MouseDoubleClickTime.
    bool            IsMouseReleased( int button );                                          // did mouse button released ( went from Down to !Down )
    bool            IsMouseHoveringWindow();                                                // is mouse hovering current window ( "window" in API names always refer to current window ). disregarding of any consideration of being blocked by a popup. ( unlike IsWindowHovered() this will return true even if the window is blocked because of a popup )
    bool            IsMouseHoveringAnyWindow();                                             // is mouse hovering any visible window
    bool            IsMouseHoveringRect( const ref ImVec2 r_min, const ref ImVec2 r_max, bool clip = true );  // is mouse hovering given bounding rect ( in screen space ). clipped by current clipping settings. disregarding of consideration of focus/window ordering/blocked by a popup.
    bool            IsMouseDragging( int button = 0, float lock_threshold = -1.0f );        // is mouse dragging. if lock_threshold < -1.0f uses io.MouseDraggingThreshold
    ImVec2          GetMousePos();                                                          // shortcut to ImGui::GetIO().MousePos provided by user, to be consistent with other calls
    ImVec2          GetMousePosOnOpeningCurrentPopup();                                     // retrieve backup of mouse positioning at the time of opening popup we have BeginPopup() into
    ImVec2          GetMouseDragDelta( int button = 0, float lock_threshold = -1.0f );      // dragging amount since clicking. if lock_threshold < -1.0f uses io.MouseDraggingThreshold
    void            ResetMouseDragDelta( int button = 0 );                                  //
    ImGuiMouseCursor GetMouseCursor();                                                      // get desired cursor type, reset in ImGui::NewFrame(), this updated during the frame. valid before Render(). If you use software rendering by setting io.MouseDrawCursor ImGui will render those for you
    void            SetMouseCursor( ImGuiMouseCursor type );                                // set desired cursor type
    void            CaptureKeyboardFromApp( bool capture = true );                          // manually override io.WantCaptureKeyboard flag next frame ( said flag is entirely left for your application handle ). e.g. force capture keyboard when your widget is being hovered.
    void            CaptureMouseFromApp( bool capture = true );                             // manually override io.WantCaptureMouse flag next frame ( said flag is entirely left for your application handle ).

    // Helpers functions to access functions pointers in ImGui::GetIO()
    void*           MemAlloc( size_t sz );
    void            MemFree( void* ptr );
    const( char )*  GetClipboardText();
    void            SetClipboardText( const( char )* text );

    // Internal context access - if you want to use multiple context, share context between modules ( e.g. DLL ). There is a default context created and active by default.
    // All contexts share a same ImFontAtlas by default. If you want different font atlas, you can new() them and overwrite the GetIO().Fonts variable of an ImGui context.
//  const( char )*  GetVersion();
//  ImGuiContext*   CreateContext( void* function( size_t ) malloc_fn = null, void function( void* ) free_fn = null );
//  void            DestroyContext( ImGuiContext* ctx );
//  ImGuiContext*   GetCurrentContext();
//  void            SetCurrentContext( ImGuiContext* ctx );


    // wrapper functions added to circumvent interface bugs
    void    GetContentRegionMax( ref ImVec2 result );                                              // current content boundaries (typically window boundaries including scrolling, or current column boundaries), in windows coordinates
    void    GetContentRegionAvail( ref ImVec2 result );                                            // == GetContentRegionMax() - GetCursorPos()
    void    GetWindowContentRegionMin( ref ImVec2 result );                                        // content boundaries min (roughly (0,0)-Scroll), in window coordinates
    void    GetWindowContentRegionMax( ref ImVec2 result );                                        // content boundaries max (roughly (0,0)+Size-Scroll) where Size can be override with SetNextWindowContentSize(), in window coordinates
    void    GetWindowPos( ref ImVec2 result );                                                     // get current window position in screen space (useful if you want to do your own drawing via the DrawList api)
    void    GetWindowSize( ref ImVec2 result );                                                    // get current window size
    void    GetFontTexUvWhitePixel( ref ImVec2 result );                                           // get UV coordinate for a while pixel, useful to draw custom shapes via the ImDrawList API
    void    GetCursorPos( ref ImVec2 result );                                                     // cursor position is relative to window position
    void    GetCursorStartPos( ref ImVec2 result );                                                // initial cursor position
    void    GetCursorScreenPos( ref ImVec2 result );                                               // cursor position in absolute screen coordinates [0..io.DisplaySize] (useful to work with ImDrawList API)
    void    GetItemRectMin( ref ImVec2 result );                                                   // get bounding rect of last item in screen space
    void    GetItemRectMax( ref ImVec2 result );                                                   // "
    void    GetItemRectSize( ref ImVec2 result );                                                  // "
    void    CalcItemRectClosestPoint( ref ImVec2 result,  const ref ImVec2 pos, bool on_edge = false, float outward = 0.0f );   // utility to find the closest point the last item bounding rectangle edge. useful to visually link items
    void    CalcTextSize( ref ImVec2 result,  const( char )* text, const( char )* text_end = null, bool hide_text_after_double_hash = false, float wrap_width = -1.0f );
    void    GetMousePos( ref ImVec2 result );                                                      // shortcut to ImGui::GetIO().MousePos provided by user, to be consistent with other calls
    void    GetMousePosOnOpeningCurrentPopup( ref ImVec2 result );                                 // retrieve backup of mouse positioning at the time of opening popup we have BeginPopup() into
    void    GetMouseDragDelta( ref ImVec2 result,  int button = 0, float lock_threshold = -1.0f );    // dragging amount since clicking. if lock_threshold < -1.0f uses io.MouseDraggingThreshold
//  void    CalcTextSizeA( ref ImVec2 result,  float size, float max_width, float wrap_width, const( char )* text_begin, const( char )* text_end = NULL, const( char )** remaining = null ) const; // utf8
}
