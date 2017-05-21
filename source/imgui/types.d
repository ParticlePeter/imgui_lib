/*
 * Copyright ( c ) 2015 Derelict Developers
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
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES ( INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION ) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT ( INCLUDING
 * NEGLIGENCE OR OTHERWISE ) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module imgui.types;
//import derelict.util.system;

// Define assertion handler.
version( IM_USER_ASSERT ) {}
else { void IM_ASSERT( bool b ) { assert( b ); }}

extern( C++ ) nothrow @nogc:

// Forward declarations
//struct ImDrawChannel;               // Temporary storage for outputting drawing commands out of order, used by ImDrawList::ChannelsSplit()
//struct ImDrawCmd;                   // A single draw command within a parent ImDrawList ( generally maps to 1 GPU draw call )
//struct ImDrawData;                  // All draw command lists required to render the frame
//struct ImDrawList;                  // A single draw command list ( generally one per window )
//struct ImDrawVert;                  // A single vertex ( 20 bytes by default, override layout with IMGUI_OVERRIDE_DRAWVERT_STRUCT_LAYOUT )
//struct ImFont;                      // Runtime data for a single font within a parent ImFontAtlas
//struct ImFontAtlas;                 // Runtime data for multiple fonts, bake multiple fonts into a single texture, TTF font loader
//struct ImFontConfig;                // Configuration data when adding a font or merging fonts
//struct ImColor;                     // Helper functions to create a color that can be converted to either u32 or float4
//struct ImGuiIO;                     // Main configuration and I/O between your application and ImGui
//struct ImGuiOnceUponAFrame;         // Simple helper for running a block of code not more than once a frame, used by IMGUI_ONCE_UPON_A_FRAME macro
//struct ImGuiStorage;                // Simple custom key value storage
//struct ImGuiStyle;                  // Runtime data for styling/colors
//struct ImGuiTextFilter;             // Parse and apply text filters. In format "aaaaa[,bbbb][,ccccc]"
//struct ImGuiTextBuffer;             // Text buffer for logging/accumulating text
//struct ImGuiTextEditCallbackData;   // Shared state of ImGui::InputText() when using custom ImGuiTextEditCallback ( rare/advanced use )
//struct ImGuiSizeConstraintCallbackData;// Structure used to constraint window size in custom ways when using custom ImGuiSizeConstraintCallback ( rare/advanced use )
//struct ImGuiListClipper;            // Helper to manually clip large list of items
//struct ImGuiContext;                // ImGui context ( opaque )

// Typedefs and Enumerations ( declared as int for compatibility and to not pollute the top of this file )
alias uint  ImU32;                  // 32-bit unsigned integer ( typically used to store packed colors )
alias uint  ImGuiID;                // unique ID used by widgets ( typically hashed from a stack of string )
alias ushort ImWchar;               // character for keyboard input/display
alias void* ImTextureID;            // user data to identify a texture ( this is whatever to you want it to be! read the FAQ about ImTextureID in imgui.cpp )
alias int   ImGuiCol;               // a color identifier for styling           // enum // ImGuiCol_
alias int   ImGuiStyleVar;          // a variable identifier for styling        // enum // ImGuiStyleVar_
alias int   ImGuiKey;               // a key identifier ( ImGui-side enum // )    // enum // ImGuiKey_
alias int   ImGuiColorEditMode;     // color edit mode for ColorEdit*()         // enum // ImGuiColorEditMode_
alias int   ImGuiMouseCursor;       // a mouse cursor identifier                // enum // ImGuiMouseCursor_
alias int   ImGuiWindowFlags;       // window flags for Begin*()                // enum // ImGuiWindowFlags_
alias int   ImGuiSetCond;           // condition flags for Set*()               // enum // ImGuiSetCond_
alias int   ImGuiInputTextFlags;    // flags for InputText*()                   // enum // ImGuiInputTextFlags_
alias int   ImGuiSelectableFlags;   // flags for Selectable()                   // enum // ImGuiSelectableFlags_
alias int   ImGuiTreeNodeFlags;     // flags for TreeNode*(), Collapsing*()     // enum // ImGuiTreeNodeFlags_
alias int   function( ImGuiTextEditCallbackData* data )         ImGuiTextEditCallback;
alias void  function( ImGuiSizeConstraintCallbackData* data )   ImGuiSizeConstraintCallback;

// Others helpers at bottom of the file:
// class ImVector<>                 // Lightweight std::vector like class.
// IMGUI_ONCE_UPON_A_FRAME          // Execute a block of code once per frame only ( convenient for creating UI within deep-nested code that runs multiple times )

struct ImVec2
{
    float x = 0, y = 0;
    //  this() { x = y = 0.0f; }
    this( float _x, float _y ) nothrow @nogc { x = _x; y = _y; }
    //  version( IM_VEC2_CLASS_EXTRA ) {            // Define constructor and implicit cast operators in imconfig.h to convert back<>forth from your math types and ImVec2.
    //      IM_VEC2_CLASS_EXTRA                     // use mixins in DLand
    //  }
}

struct ImVec4
{
    float x = 0, y = 0, z = 0, w = 0;
    //  this() { x = y = z = w = 0.0f; }
    this( float _x, float _y, float _z, float _w ) nothrow @nogc { x = _x; y = _y; z = _z; w = _w; }
    //float[4]    opCast( float[4] )                           { float[4] result = [ x, y, z, w ]; return result; }
    //float[3]    opCast( float[3] )                           { float[3] result = [ x, y, z    ]; return result; }
    //  version( IM_VEC4_CLASS_EXTRA ) {            // Define constructor and implicit cast operators in imconfig.h to convert back<>forth from your math types and ImVec4.
    //      IM_VEC4_CLASS_EXTRA                     // use mixins in DLand
    //  }
}


enum // ImGuiWindowFlags_
{
    // Default: 0
    ImGuiWindowFlags_NoTitleBar             = 1 << 0,   // Disable title-bar
    ImGuiWindowFlags_NoResize               = 1 << 1,   // Disable user resizing with the lower-right grip
    ImGuiWindowFlags_NoMove                 = 1 << 2,   // Disable user moving the window
    ImGuiWindowFlags_NoScrollbar            = 1 << 3,   // Disable scrollbars ( window can still scroll with mouse or programatically )
    ImGuiWindowFlags_NoScrollWithMouse      = 1 << 4,   // Disable user vertically scrolling with mouse wheel
    ImGuiWindowFlags_NoCollapse             = 1 << 5,   // Disable user collapsing window by double-clicking on it
    ImGuiWindowFlags_AlwaysAutoResize       = 1 << 6,   // Resize every window to its content every frame
    ImGuiWindowFlags_ShowBorders            = 1 << 7,   // Show borders around windows and items
    ImGuiWindowFlags_NoSavedSettings        = 1 << 8,   // Never load/save settings in .ini file
    ImGuiWindowFlags_NoInputs               = 1 << 9,   // Disable catching mouse or keyboard inputs
    ImGuiWindowFlags_MenuBar                = 1 << 10,  // Has a menu-bar
    ImGuiWindowFlags_HorizontalScrollbar    = 1 << 11,  // Allow horizontal scrollbar to appear ( off by default ). You may use SetNextWindowContentSize( ImVec2( width,0.0f )); prior to calling Begin() to specify width. Read code in imgui_demo in the "Horizontal Scrolling" section.
    ImGuiWindowFlags_NoFocusOnAppearing     = 1 << 12,  // Disable taking focus when transitioning from hidden to visible state
    ImGuiWindowFlags_NoBringToFrontOnFocus  = 1 << 13,  // Disable bringing window to front when taking focus ( e.g. clicking on it or programatically giving it focus )
    ImGuiWindowFlags_AlwaysVerticalScrollbar= 1 << 14,  // Always show vertical scrollbar ( even if ContentSize.y < Size.y )
    ImGuiWindowFlags_AlwaysHorizontalScrollbar=1<< 15,  // Always show horizontal scrollbar ( even if ContentSize.x < Size.x )
    ImGuiWindowFlags_AlwaysUseWindowPadding = 1 << 16,  // Ensure child windows without border uses style.WindowPadding ( ignored by default for non-bordered child windows, because more convenient )
    // [Internal]
    ImGuiWindowFlags_ChildWindow            = 1 << 20,  // Don't use! For internal use by BeginChild()
    ImGuiWindowFlags_ChildWindowAutoFitX    = 1 << 21,  // Don't use! For internal use by BeginChild()
    ImGuiWindowFlags_ChildWindowAutoFitY    = 1 << 22,  // Don't use! For internal use by BeginChild()
    ImGuiWindowFlags_ComboBox               = 1 << 23,  // Don't use! For internal use by ComboBox()
    ImGuiWindowFlags_Tooltip                = 1 << 24,  // Don't use! For internal use by BeginTooltip()
    ImGuiWindowFlags_Popup                  = 1 << 25,  // Don't use! For internal use by BeginPopup()
    ImGuiWindowFlags_Modal                  = 1 << 26,  // Don't use! For internal use by BeginPopupModal()
    ImGuiWindowFlags_ChildMenu              = 1 << 27   // Don't use! For internal use by BeginMenu()
}

// Flags for ImGui::InputText()
enum // ImGuiInputTextFlags_
{
    // Default: 0
    ImGuiInputTextFlags_CharsDecimal        = 1 << 0,   // Allow 0123456789.+-*/
    ImGuiInputTextFlags_CharsHexadecimal    = 1 << 1,   // Allow 0123456789ABCDEFabcdef
    ImGuiInputTextFlags_CharsUppercase      = 1 << 2,   // Turn a..z into A..Z
    ImGuiInputTextFlags_CharsNoBlank        = 1 << 3,   // Filter out spaces, tabs
    ImGuiInputTextFlags_AutoSelectAll       = 1 << 4,   // Select entire text when first taking mouse focus
    ImGuiInputTextFlags_EnterReturnsTrue    = 1 << 5,   // Return 'true' when Enter is pressed ( as opposed to when the value was modified )
    ImGuiInputTextFlags_CallbackCompletion  = 1 << 6,   // Call user function on pressing TAB ( for completion handling )
    ImGuiInputTextFlags_CallbackHistory     = 1 << 7,   // Call user function on pressing Up/Down arrows ( for history handling )
    ImGuiInputTextFlags_CallbackAlways      = 1 << 8,   // Call user function every time. User code may query cursor position, modify text buffer.
    ImGuiInputTextFlags_CallbackCharFilter  = 1 << 9,   // Call user function to filter character. Modify data.EventChar to replace/filter input, or return 1 to discard character.
    ImGuiInputTextFlags_AllowTabInput       = 1 << 10,  // Pressing TAB input a '\t' character into the text field
    ImGuiInputTextFlags_CtrlEnterForNewLine = 1 << 11,  // In multi-line mode, unfocus with Enter, add new line with Ctrl+Enter ( default is opposite: unfocus with Ctrl+Enter, add line with Enter ).
    ImGuiInputTextFlags_NoHorizontalScroll  = 1 << 12,  // Disable following the cursor horizontally
    ImGuiInputTextFlags_AlwaysInsertMode    = 1 << 13,  // Insert mode
    ImGuiInputTextFlags_ReadOnly            = 1 << 14,  // Read-only mode
    ImGuiInputTextFlags_Password            = 1 << 15,  // Password mode, display all characters as '*'
    // [Internal]
    ImGuiInputTextFlags_Multiline           = 1 << 20   // For internal use by InputTextMultiline()
}

// Flags for ImGui::TreeNodeEx(), ImGui::CollapsingHeader*()
enum // ImGuiTreeNodeFlags_
{
    ImGuiTreeNodeFlags_Selected             = 1 << 0,   // Draw as selected
    ImGuiTreeNodeFlags_Framed               = 1 << 1,   // Full colored frame ( e.g. for CollapsingHeader )
    ImGuiTreeNodeFlags_AllowOverlapMode     = 1 << 2,   // Hit testing to allow subsequent widgets to overlap this one
    ImGuiTreeNodeFlags_NoTreePushOnOpen     = 1 << 3,   // Don't do a TreePush() when open ( e.g. for CollapsingHeader ) = no extra indent nor pushing on ID stack
    ImGuiTreeNodeFlags_NoAutoOpenOnLog      = 1 << 4,   // Don't automatically and temporarily open node when Logging is active ( by default logging will automatically open tree nodes )
    ImGuiTreeNodeFlags_DefaultOpen          = 1 << 5,   // Default node to be open
    ImGuiTreeNodeFlags_OpenOnDoubleClick    = 1 << 6,   // Need double-click to open node
    ImGuiTreeNodeFlags_OpenOnArrow          = 1 << 7,   // Only open when clicking on the arrow part. If ImGuiTreeNodeFlags_OpenOnDoubleClick is also set, single-click arrow or double-click all box to open.
    ImGuiTreeNodeFlags_Leaf                 = 1 << 8,   // No collapsing, no arrow ( use as a convenience for leaf nodes ).
    ImGuiTreeNodeFlags_Bullet               = 1 << 9,   // Display a bullet instead of arrow
    //ImGuITreeNodeFlags_SpanAllAvailWidth  = 1 << 10,  // FIXME: TODO: Extend hit box horizontally even if not framed
    //ImGuiTreeNodeFlags_NoScrollOnOpen     = 1 << 11,  // FIXME: TODO: Disable automatic scroll on TreePop() if node got just open and contents is not visible
    ImGuiTreeNodeFlags_CollapsingHeader     = ImGuiTreeNodeFlags_Framed | ImGuiTreeNodeFlags_NoAutoOpenOnLog
}

// Flags for ImGui::Selectable()
enum // ImGuiSelectableFlags_
{
    // Default: 0
    ImGuiSelectableFlags_DontClosePopups    = 1 << 0,   // Clicking this don't close parent popup window
    ImGuiSelectableFlags_SpanAllColumns     = 1 << 1,   // Selectable frame can span all columns ( text will still fit in current column )
    ImGuiSelectableFlags_AllowDoubleClick   = 1 << 2    // Generate press events on double clicks too
}

// User fill ImGuiIO.KeyMap[] array with indices into the ImGuiIO.KeysDown[512] array
enum // ImGuiKey_
{
    ImGuiKey_Tab,       // for tabbing through fields
    ImGuiKey_LeftArrow, // for text edit
    ImGuiKey_RightArrow,// for text edit
    ImGuiKey_UpArrow,   // for text edit
    ImGuiKey_DownArrow, // for text edit
    ImGuiKey_PageUp,
    ImGuiKey_PageDown,
    ImGuiKey_Home,      // for text edit
    ImGuiKey_End,       // for text edit
    ImGuiKey_Delete,    // for text edit
    ImGuiKey_Backspace, // for text edit
    ImGuiKey_Enter,     // for text edit
    ImGuiKey_Escape,    // for text edit
    ImGuiKey_A,         // for text edit CTRL+A: select all
    ImGuiKey_C,         // for text edit CTRL+C: copy
    ImGuiKey_V,         // for text edit CTRL+V: paste
    ImGuiKey_X,         // for text edit CTRL+X: cut
    ImGuiKey_Y,         // for text edit CTRL+Y: redo
    ImGuiKey_Z,         // for text edit CTRL+Z: undo
    ImGuiKey_COUNT
}

// Enumeration for PushStyleColor() / PopStyleColor()
enum // ImGuiCol_
{
    ImGuiCol_Text,
    ImGuiCol_TextDisabled,
    ImGuiCol_WindowBg,              // Background of normal windows
    ImGuiCol_ChildWindowBg,         // Background of child windows
    ImGuiCol_PopupBg,               // Background of popups, menus, tooltips windows
    ImGuiCol_Border,
    ImGuiCol_BorderShadow,
    ImGuiCol_FrameBg,               // Background of checkbox, radio button, plot, slider, text input
    ImGuiCol_FrameBgHovered,
    ImGuiCol_FrameBgActive,
    ImGuiCol_TitleBg,
    ImGuiCol_TitleBgCollapsed,
    ImGuiCol_TitleBgActive,
    ImGuiCol_MenuBarBg,
    ImGuiCol_ScrollbarBg,
    ImGuiCol_ScrollbarGrab,
    ImGuiCol_ScrollbarGrabHovered,
    ImGuiCol_ScrollbarGrabActive,
    ImGuiCol_ComboBg,
    ImGuiCol_CheckMark,
    ImGuiCol_SliderGrab,
    ImGuiCol_SliderGrabActive,
    ImGuiCol_Button,
    ImGuiCol_ButtonHovered,
    ImGuiCol_ButtonActive,
    ImGuiCol_Header,
    ImGuiCol_HeaderHovered,
    ImGuiCol_HeaderActive,
    ImGuiCol_Column,
    ImGuiCol_ColumnHovered,
    ImGuiCol_ColumnActive,
    ImGuiCol_ResizeGrip,
    ImGuiCol_ResizeGripHovered,
    ImGuiCol_ResizeGripActive,
    ImGuiCol_CloseButton,
    ImGuiCol_CloseButtonHovered,
    ImGuiCol_CloseButtonActive,
    ImGuiCol_PlotLines,
    ImGuiCol_PlotLinesHovered,
    ImGuiCol_PlotHistogram,
    ImGuiCol_PlotHistogramHovered,
    ImGuiCol_TextSelectedBg,
    ImGuiCol_ModalWindowDarkening,  // darken entire screen when a modal window is active
    ImGuiCol_COUNT
}

// Enumeration for PushStyleVar() / PopStyleVar()
// NB: the enum // only refers to fields of ImGuiStyle() which makes sense to be pushed/poped in UI code. Feel free to add others.
enum // ImGuiStyleVar_
{
    ImGuiStyleVar_Alpha,               // float
    ImGuiStyleVar_WindowPadding,       // ImVec2
    ImGuiStyleVar_WindowRounding,      // float
    ImGuiStyleVar_WindowMinSize,       // ImVec2
    ImGuiStyleVar_ChildWindowRounding, // float
    ImGuiStyleVar_FramePadding,        // ImVec2
    ImGuiStyleVar_FrameRounding,       // float
    ImGuiStyleVar_ItemSpacing,         // ImVec2
    ImGuiStyleVar_ItemInnerSpacing,    // ImVec2
    ImGuiStyleVar_IndentSpacing,       // float
    ImGuiStyleVar_GrabMinSize,         // float
    ImGuiStyleVar_ButtonTextAlign,     // flags ImGuiAlign_*
    ImGuiStyleVar_Count_
}

// Enumeration for ColorEditMode()
// FIXME-OBSOLETE: Will be replaced by future color/picker api
enum // ImGuiColorEditMode_
{
    ImGuiColorEditMode_UserSelect = -2,
    ImGuiColorEditMode_UserSelectShowButton = -1,
    ImGuiColorEditMode_RGB = 0,
    ImGuiColorEditMode_HSV = 1,
    ImGuiColorEditMode_HEX = 2
}

// Enumeration for GetMouseCursor()
enum // ImGuiMouseCursor_
{
    ImGuiMouseCursor_None = -1,
    ImGuiMouseCursor_Arrow = 0,
    ImGuiMouseCursor_TextInput,         // When hovering over InputText, etc.
    ImGuiMouseCursor_Move,              // Unused
    ImGuiMouseCursor_ResizeNS,          // Unused
    ImGuiMouseCursor_ResizeEW,          // When hovering over a column
    ImGuiMouseCursor_ResizeNESW,        // Unused
    ImGuiMouseCursor_ResizeNWSE,        // When hovering over the bottom-right corner of a window
    ImGuiMouseCursor_Count_
}

// Condition flags for ImGui::SetWindow***(), SetNextWindow***(), SetNextTreeNode***() functions
// All those functions treat 0 as a shortcut to ImGuiSetCond_Always
enum // ImGuiSetCond_
{
    ImGuiSetCond_Always        = 1 << 0, // Set the variable
    ImGuiSetCond_Once          = 1 << 1, // Set the variable once per runtime session ( only the first call with succeed )
    ImGuiSetCond_FirstUseEver  = 1 << 2, // Set the variable if the window has no saved data ( if doesn't exist in the .ini file )
    ImGuiSetCond_Appearing     = 1 << 3  // Set the variable if the window is appearing after being hidden/inactive ( or the first time )
}

struct ImGuiStyle
{
    float       Alpha;                      // Global alpha applies to everything in ImGui
    ImVec2      WindowPadding;              // Padding within a window
    ImVec2      WindowMinSize;              // Minimum window size
    float       WindowRounding;             // Radius of window corners rounding. Set to 0.0f to have rectangular windows
    ImVec2      WindowTitleAlign;           // Alignment for title bar text. Defaults to ( 0.0f,0.5f ) for left-aligned,vertically centered.
    float       ChildWindowRounding;        // Radius of child window corners rounding. Set to 0.0f to have rectangular windows
    ImVec2      FramePadding;               // Padding within a framed rectangle ( used by most widgets )
    float       FrameRounding;              // Radius of frame corners rounding. Set to 0.0f to have rectangular frame ( used by most widgets ).
    ImVec2      ItemSpacing;                // Horizontal and vertical spacing between widgets/lines
    ImVec2      ItemInnerSpacing;           // Horizontal and vertical spacing between within elements of a composed widget ( e.g. a slider and its label )
    ImVec2      TouchExtraPadding;          // Expand reactive bounding box for touch-based system where touch position is not accurate enough. Unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. So don't grow this too much!
    float       IndentSpacing;              // Horizontal indentation when e.g. entering a tree node. Generally == ( FontSize + FramePadding.x*2 ).
    float       ColumnsMinSpacing;          // Minimum horizontal spacing between two columns
    float       ScrollbarSize;              // Width of the vertical scrollbar, Height of the horizontal scrollbar
    float       ScrollbarRounding;          // Radius of grab corners for scrollbar
    float       GrabMinSize;                // Minimum width/height of a grab box for slider/scrollbar.
    float       GrabRounding;               // Radius of grabs corners rounding. Set to 0.0f to have rectangular slider grabs.
    ImVec2      ButtonTextAlign;            // Alignment of button text when button is larger than text. Defaults to ( 0.5f,0.5f ) for horizontally+vertically centered.
    ImVec2      DisplayWindowPadding;       // Window positions are clamped to be visible within the display area by at least this amount. Only covers regular windows.
    ImVec2      DisplaySafeAreaPadding;     // If you cannot see the edge of your screen ( e.g. on a TV ) increase the safe area padding. Covers popups/tooltips as well regular windows.
    bool        AntiAliasedLines;           // Enable anti-aliasing on lines/borders. Disable if you are really tight on CPU/GPU.
    bool        AntiAliasedShapes;          // Enable anti-aliasing on filled shapes ( rounded rectangles, circles, etc. )
    float       CurveTessellationTol;       // Tessellation tolerance. Decrease for highly tessellated curves ( higher quality, more polygons ), increase to reduce quality.
    ImVec4[ ImGuiCol_COUNT ] Colors;

    //IMGUI_API ImGuiStyle();
}

// This is where your app communicate with ImGui. Access via ImGui::GetIO().
// Read 'Programmer guide' section in .cpp file for general usage.
struct ImGuiIO
{
    //------------------------------------------------------------------
    // Settings ( fill once )                 // Default value:
    //------------------------------------------------------------------

    ImVec2        DisplaySize;              // <unset>              // Display size, in pixels. For clamping windows positions.
    float         DeltaTime;                // = 1.0f/60.0f         // Time elapsed since last frame, in seconds.
    float         IniSavingRate;            // = 5.0f               // Maximum time between saving positions/sizes to .ini file, in seconds.
    const(char)*  IniFilename;              // = "imgui.ini"        // Path to .ini file. null to disable .ini saving.
    const(char)*  LogFilename;              // = "imgui_log.txt"    // Path to .log file ( default parameter to ImGui::LogToFile when no file is specified ).
    float         MouseDoubleClickTime;     // = 0.30f              // Time for a double-click, in seconds.
    float         MouseDoubleClickMaxDist;  // = 6.0f               // Distance threshold to stay in to validate a double-click, in pixels.
    float         MouseDragThreshold;       // = 6.0f               // Distance threshold before considering we are dragging
    int[ ImGuiKey_COUNT ]           KeyMap; // <unset>              // Map of indices into the KeysDown[512] entries array
    float         KeyRepeatDelay;           // = 0.250f             // When holding a key/button, time before it starts repeating, in seconds ( for buttons in Repeat mode, etc. ).
    float         KeyRepeatRate;            // = 0.020f             // When holding a key/button, rate at which it repeats, in seconds.
    void*         UserData;                 // = null               // Store your own data for retrieval by callbacks.

    ImFontAtlas*  Fonts;                    // <auto>               // Load and assemble one or more fonts into a single tightly packed texture. Output to Fonts array.
    float         FontGlobalScale;          // = 1.0f               // Global scale all fonts
    bool          FontAllowUserScaling;     // = false              // Allow user scaling text of individual window with CTRL+Wheel.
    ImFont*       FontDefault;              // = null               // Font to use on NewFrame(). Use null to uses Fonts.Fonts[0].
    ImVec2        DisplayFramebufferScale;  // = ( 1.0f,1.0f )        // For retina display or other situations where window coordinates are different from framebuffer coordinates. User storage only, presently not used by ImGui.
    ImVec2        DisplayVisibleMin;        // <unset> ( 0.0f,0.0f )  // If you use DisplaySize as a virtual space larger than your screen, set DisplayVisibleMin/Max to the visible area.
    ImVec2        DisplayVisibleMax;        // <unset> ( 0.0f,0.0f )  // If the values are the same, we defaults to Min=( 0.0f ) and Max=DisplaySize

    // Advanced/subtle behaviors
    bool          OSXBehaviors;             // = defined( __APPLE__ ) // OS X style: Text editing cursor movement using Alt instead of Ctrl, Shortcuts using Cmd/Super instead of Ctrl, Line/Text Start and End using Cmd+Arrows instead of Home/End, Double click selects by word instead of selecting whole text, Multi-selection in lists uses Cmd/Super instead of Ctrl

    //------------------------------------------------------------------
    // User Functions
    //------------------------------------------------------------------

    // Rendering function, will be called in Render().
    // Alternatively you can keep this to null and call GetDrawData() after Render() to get the same pointer.
    // See example applications if you are unsure of how to implement this.
    void            function( ImDrawData* data )                    RenderDrawListsFn;

    // Optional: access OS clipboard
    // ( default to use native Win32 clipboard on Windows, otherwise uses a private clipboard. Override to access OS clipboard on other architectures )
    const(char)*    function( void* user_data )                     GetClipboardTextFn;
    void            function( void* user_data, const(char)* text )  SetClipboardTextFn;
    void*           ClipboardUserData;

    // Optional: override memory allocations. MemFreeFn() may be called with a null pointer.
    // ( default to posix malloc/free )
    void*           function( size_t size )                         MemAllocFn;
    void            function( void*  ptr )                          MemFreeFn;

    // Optional: notify OS Input Method Editor of the screen position of your cursor for text input position ( e.g. when using Japanese/Chinese IME in Windows )
    // ( default to use native imm32 api on Windows )
    void            function( int x, int y )                        ImeSetInputScreenPosFn;
    void*           ImeWindowHandle;            // ( Windows ) Set this to your HWND to get automatic IME cursor positioning.

    //------------------------------------------------------------------
    // Input - Fill before calling NewFrame()
    //------------------------------------------------------------------

    ImVec2          MousePos;           // Mouse position, in pixels ( set to -1,-1 if no mouse / on another screen, etc. )
    bool[5]         MouseDown;          // Mouse buttons: left, right, middle + extras. ImGui itself mostly only uses left button ( BeginPopupContext** are using right button ). Others buttons allows us to track if the mouse is being used by your application + available to user as a convenience via IsMouse** API.
    float           MouseWheel;         // Mouse wheel: 1 unit scrolls about 5 lines text.
    bool            MouseDrawCursor;    // Request ImGui to draw a mouse cursor for you ( if you are on a platform without a mouse cursor ).
    bool            KeyCtrl;            // Keyboard modifier pressed: Control
    bool            KeyShift;           // Keyboard modifier pressed: Shift
    bool            KeyAlt;             // Keyboard modifier pressed: Alt
    bool            KeySuper;           // Keyboard modifier pressed: Cmd/Super/Windows
    bool[512]       KeysDown;           // Keyboard keys that are pressed ( in whatever storage order you naturally have access to keyboard data )
    ImWchar[16+1]   InputCharacters;    // List of characters input ( translated by user from keypress+keyboard state ). Fill using AddInputCharacter() helper.

    // Functions
    void AddInputCharacter( ImWchar c ) nothrow;                // Add new character into InputCharacters[]
    void AddInputCharactersUTF8( const(char)* utf8_chars );      // Add new characters into InputCharacters[] from an UTF-8 string
    void ClearInputCharacters() { InputCharacters[0] = 0; }     // Clear the text input buffer manually

    //------------------------------------------------------------------
    // Output - Retrieve after calling NewFrame()
    //------------------------------------------------------------------

    bool        WantCaptureMouse;           // Mouse is hovering a window or widget is active ( = ImGui will use your mouse input ). Use to hide mouse from the rest of your application
    bool        WantCaptureKeyboard;        // Widget is active ( = ImGui will use your keyboard input ). Use to hide keyboard from the rest of your application
    bool        WantTextInput;              // Some text input widget is active, which will read input characters from the InputCharacters array. Use to activate on screen keyboard if your system needs one
    float       Framerate;                  // Application framerate estimation, in frame per second. Solely for convenience. Rolling average estimation based on IO.DeltaTime over 120 frames
    int         MetricsAllocs;              // Number of active memory allocations
    int         MetricsRenderVertices;      // Vertices output during last call to Render()
    int         MetricsRenderIndices;       // Indices output during last call to Render() = number of triangles * 3
    int         MetricsActiveWindows;       // Number of visible root windows ( exclude child windows )
    ImVec2      MouseDelta;                 // Mouse delta. Note that this is zero if either current or previous position are negative, so a disappearing/reappearing mouse won't have a huge delta for one frame.

    //------------------------------------------------------------------
    // [Private] ImGui will maintain those fields. Forward compatibility not guaranteed!
    //------------------------------------------------------------------

    ImVec2      MousePosPrev;               // Previous mouse position temporary storage ( nb: not for public use, set to MousePos in NewFrame())
    bool[5]     MouseClicked;               // Mouse button went from !Down to Down
    ImVec2[5]   MouseClickedPos;            // Position at time of clicking
    float[5]    MouseClickedTime;           // Time of last click ( used to figure out double-click )
    bool[5]     MouseDoubleClicked;         // Has mouse button been double-clicked?
    bool[5]     MouseReleased;              // Mouse button went from Down to !Down
    bool[5]     MouseDownOwned;             // Track if button was clicked inside a window. We don't request mouse capture from the application if click started outside ImGui bounds.
    float[5]    MouseDownDuration;          // Duration the mouse button has been down ( 0.0f == just clicked )
    float[5]    MouseDownDurationPrev;      // Previous time the mouse button has been down
    float[5]    MouseDragMaxDistanceSqr;    // Squared maximum distance of how much mouse has traveled from the click point
    float[512]  KeysDownDuration;           // Duration the keyboard key has been down ( 0.0f == just pressed )
    float[512]  KeysDownDurationPrev;       // Previous duration the key has been down

    //IMGUI_API   ImGuiIO();
}

//-----------------------------------------------------------------------------
// Helpers
//-----------------------------------------------------------------------------

// Lightweight std::vector<> like class to avoid dragging dependencies ( also: windows implementation of STL with debug enabled is absurdly slow, so let's bypass it so our code runs fast in debug ).
// Our implementation does NOT call c++ constructors because we don't use them in ImGui. Don't use this class as a straight std::vector replacement in your code!
//template<typename T>
struct ImVector( T )
{
    //public:
    int                 Size;
    int                 Capacity;
    T*                  Data;

    alias T             value_type;
    alias T*            iterator;
    alias const T*      const_iterator;

    //this()              { Size = Capacity = 0; Data = null; }
    //this( T val )       { import imgui.funcs_static : MemAlloc; Data = cast( T* )MemAlloc( cast( size_t )( 8 * T.sizeof )); Size = 1; Capacity = 8; *Data = val; }
    //~this()             { if( Data ) { import imgui.funcs_static : MemFree; MemFree( Data ); }}

          ref T opIndex( int i )            { IM_ASSERT( i < Size ); return Data[i]; }
    //ref const( T ) opIndex( int i )            { IM_ASSERT( i < Size ); return Data[i]; }
    //void opIndexAssign( value_type v, int i ) ;//{ IM_ASSERT( i < Size ); Data[i] = v; }

    extern( C++ ):
    bool                empty() const      ;//{ return Size == 0; }
    int                 size() const       ;//{ return Size; }
    int                 capacity() const   ;//{ return Capacity; }

    void                clear()             ;//{ if( Data ) { Size = Capacity = 0; MemFree( Data ); Data = null; } }
    iterator            begin()             ;//{ return Data; }
//  const_iterator      begin()             ;//{ return Data; }
    iterator            end()               ;//{ return Data + Size; }
//  const_iterator      end() const         ;//{ return Data + Size; }
    ref T               front()             ;//{ IM_ASSERT( Size > 0 ); return Data[0]; }
    const ref T         front()             ;//{ IM_ASSERT( Size > 0 ); return Data[0]; }
    ref T               back()              ;//{ IM_ASSERT( Size > 0 ); return Data[Size-1]; }
    const ref T         back()              ;//{ IM_ASSERT( Size > 0 ); return Data[Size-1]; }
    void                swap( ref ImVector!T )          ;//{ int rhs_size = rhs.Size; rhs.Size = Size; Size = rhs_size; int rhs_cap = rhs.Capacity; rhs.Capacity = Capacity; Capacity = rhs_cap; value_type* rhs_data = rhs.Data; rhs.Data = Data; Data = rhs_data; }

    int                 _grow_capacity( int new_size )  ;//{ int new_capacity = Capacity ? ( Capacity + Capacity/2 ) : 8; return new_capacity > new_size ? new_capacity : new_size; }

    void                resize( int new_size )          ;//{ if( new_size > Capacity ) reserve( _grow_capacity( new_size )); Size = new_size; }
    void                reserve( int new_capacity )     ;/*
    {
        if( new_capacity <= Capacity ) return;
        T* new_data = cast( value_type* )MemAlloc( cast( size_t )new_capacity * sizeof( value_type ));
        import core.stdc.string : memcpy;
        if( Data )  memcpy( new_data, Data, cast( size_t )Size * value_type.sizeof );
        MemFree( Data );
        Data = new_data;
        Capacity = new_capacity;
    }*/

    void                    push_back( const ref value_type v ) ;//{ if( Size == Capacity ) reserve( _grow_capacity( Size + 1 )); Data[ Size++ ] = v; }
    void                    pop_back()                  ;//{ IM_ASSERT( Size > 0 ); Size--; }

    iterator                erase( const_iterator it )  ;//{ IM_ASSERT( it >= Data && it < Data + Size ); const ptrdiff_t off = it - Data; memmove( Data + off, Data + off + 1, ( cast( size_t )Size - cast( size_t )off - 1 ) * value_type.sizeof ); Size--; return Data + off; }
    iterator                insert( const_iterator it, const ref value_type v )  ;//{ IM_ASSERT( it >= Data && it <= Data + Size ); const ptrdiff_t off = it - Data; if( Size == Capacity ) reserve( Capacity ? Capacity * 2 : 4 ); if( off < cast( int )Size ) memmove( Data + off + 1, Data + off, ( cast( size_t )Size - cast( size_t )off ) * value_type.sizeof ); Data[ off ] = v; Size++; return Data + off; }
}

// Helper: execute a block of code at maximum once a frame
// Convenient if you want to quickly create an UI within deep-nested code that runs multiple times every frame.
// Usage:
//   IMGUI_ONCE_UPON_A_FRAME
//   {
//      // code block will be executed one per frame
//   }
// Attention! the macro expands into 2 statement so make sure you don't use it within e.g. an if() statement without curly braces.
/* #define IMGUI_ONCE_UPON_A_FRAME    static ImGuiOnceUponAFrame imgui_oaf##__LINE__; if( imgui_oaf##__LINE__ )
struct ImGuiOnceUponAFrame
{
    ImGuiOnceUponAFrame() { RefFrame = -1; }
    mutable int RefFrame;
    operator bool() const { int current_frame = ImGui::GetFrameCount(); if( RefFrame == current_frame ) return false; RefFrame = current_frame; return true; }
}*/

// Helper: Parse and apply text filters. In format "aaaaa[,bbbb][,ccccc]"
struct ImGuiTextFilter
{
    struct TextRange
    {
        const(char)* b;
        const(char)* e;

        //this() { b = e = null; }
        this( const(char)* _b, const(char)* _e ) { b = _b; e = _e; }
        const(char)*    begin()             ;//{ return b; }
        const(char)*    end()               ;//{ return e; }
        bool            empty()             ;//{ return b == e; }
        char            front()             ;//{ return *b; }
        static bool     is_blank( char c )  ;//{ return c == ' ' || c == '\t'; }
        void            trim_blanks()       ;//{ while( b < e && is_blank( *b )) ++b; while( e > b && is_blank( *( e-1 ))) --e; }
        void            split( char separator, ref ImVector!TextRange result );
    }

    char[256]           InputBuf;
    ImVector!TextRange  Filters;
    int                 CountGrep;

    this( const(char)*  default_filter );
    //~this() {}
    void                Clear()             ;//{ InputBuf[0] = 0; Build(); }
    bool                Draw( const(char)* label = "Filter ( inc,-exc )", float width = 0.0f );    // Helper calling InputText+Build
    bool                PassFilter( const(char)* text, const(char)* text_end = null ) const;
    bool                IsActive() const    ;//{ return !Filters.empty(); }
    void                Build();
}

// Helper: Text buffer for logging/accumulating text
struct ImGuiTextBuffer
{
    ImVector!char       Buf;// = ImVector!char( 0 );

    //this()              { Buf.push_back( 0 ); }
    char                opIndex( int i )    ;//{ return Buf.Data[i]; }
    const(char)*        begin()             ;//{ ref return Buf.front(); }
    const(char)*        end()               ;//{ ref return Buf.back(); }      // Buf is zero-terminated, so end() will point on the zero-terminator
    int                 size()              ;//{ return Buf.Size - 1; }
    bool                empty()             ;//{ return Buf.Size <= 1; }
    void                clear()             ;//{ Buf.clear(); Buf.push_back( 0 ); }
    const(char)*        c_str()             ;//{ return Buf.Data; }
    void                append( const(char)* fmt, ... );   // IM_PRINTFARGS( 2 );
    import              core.stdc.stdarg : va_list;
    void                appendv( const(char)* fmt, va_list args );
}

// Helper: Simple Key.value storage
// Typically you don't have to worry about this since a storage is held within each Window.
// We use it to e.g. store collapse state for a tree ( Int 0/1 ), store color edit options.
// You can use it as custom user storage for temporary values.
// Declare your own storage if:
// - You want to manipulate the open/close state of a particular sub-tree in your interface ( tree node uses Int 0/1 to store their state ).
// - You want to store custom debug data easily without adding or editing structures in your code.
// Types are NOT stored, so it is up to you to make sure your Key don't collide with different types.
struct ImGuiStorage
{
    struct Pair
    {
        ImGuiID key;
        union { int val_i; float val_f; void* val_p; }
        this( ImGuiID _key, int   _val_i ) { key = _key; val_i = _val_i; }
        this( ImGuiID _key, float _val_f ) { key = _key; val_f = _val_f; }
        this( ImGuiID _key, void* _val_p ) { key = _key; val_p = _val_p; }
    }
    ImVector!Pair       Data;

    // - Get***() functions find pair, never add/allocate. Pairs are sorted so a query is O( log N )
    // - Set***() functions find pair, insertion on demand if missing.
    // - Sorted insertion is costly, paid once. A typical frame shouldn't need to insert any new pair.
    void      Clear();
    int       GetInt( ImGuiID key, int default_val = 0 ) const;
    void      SetInt( ImGuiID key, int val );
    bool      GetBool( ImGuiID key, bool default_val = false ) const;
    void      SetBool( ImGuiID key, bool val ) ;
    float     GetFloat( ImGuiID key, float default_val = 0.0f ) const;
    void      SetFloat( ImGuiID key, float val );
    void*     GetVoidPtr( ImGuiID key ) const; // default_val is null
    void      SetVoidPtr( ImGuiID key, void* val );

    // - Get***Ref() functions finds pair, insert on demand if missing, return pointer. Useful if you intend to do Get+Set.
    // - References are only valid until a new value is added to the storage. Calling a Set***() function or a Get***Ref() function invalidates the pointer.
    // - A typical use case where this is convenient for quick hacking ( e.g. add storage during a live ref EditContinue session if you can't modify existing struct )
    //      float* pvar = ImGui::GetFloatRef( key ); ImGui::SliderFloat( "var", pvar, 0, 100.0f ); some_var += *pvar;
    int*      GetIntRef( ImGuiID key, int default_val = 0 );
    bool*     GetBoolRef( ImGuiID key, bool default_val = false );
    float*    GetFloatRef( ImGuiID key, float default_val = 0.0f );
    void**    GetVoidPtrRef( ImGuiID key, void* default_val = null );

    // Use on your own storage if you know only integer are being stored ( open/close all tree nodes )
    void      SetAllInt( int val );
}

// Shared state of InputText(), passed to callback when a ImGuiInputTextFlags_Callback* flag is used and the corresponding callback is triggered.
struct ImGuiTextEditCallbackData
{
    ImGuiInputTextFlags EventFlag;      // One of ImGuiInputTextFlags_Callback* // Read-only
    ImGuiInputTextFlags Flags;          // What user passed to InputText()      // Read-only
    void*               UserData;       // What user passed to InputText()      // Read-only
    bool                ReadOnly;       // Read-only mode                       // Read-only

    // CharFilter event:
    ImWchar             EventChar;      // Character input                      // Read-write ( replace character or set to zero )

    // Completion,History,Always events:
    // If you modify the buffer contents make sure you update 'BufTextLen' and set 'BufDirty' to true.
    ImGuiKey            EventKey;       // Key pressed ( Up/Down/TAB )            // Read-only
    char*               Buf;            // Current text buffer                  // Read-write ( pointed data only, can't replace the actual pointer )
    int                 BufTextLen;     // Current text length in bytes         // Read-write
    int                 BufSize;        // Maximum text length in bytes         // Read-only
    bool                BufDirty;       // Set if you modify Buf/BufTextLen!!   // Write
    int                 CursorPos;      //                                      // Read-write
    int                 SelectionStart; //                                      // Read-write ( == to SelectionEnd when no selection )
    int                 SelectionEnd;   //                                      // Read-write

    // NB: Helper functions for text manipulation. Calling those function loses selection.
    void    DeleteChars( int pos, int bytes_count );
    void    InsertChars( int pos, const(char)* text, const(char)* text_end = null );
    bool    HasSelection() const { return SelectionStart != SelectionEnd; }
}

// Resizing callback data to apply custom constraint. As enabled by SetNextWindowSizeConstraints(). Callback is called during the next Begin().
// NB: For basic min/max size constraint on each axis you don't need to use the callback! The SetNextWindowSizeConstraints() parameters are enough.
struct ImGuiSizeConstraintCallbackData
{
    void*   UserData;       // Read-only.   What user passed to SetNextWindowSizeConstraints()
    ImVec2  Pos;            // Read-only.   Window position, for reference.
    ImVec2  CurrentSize;    // Read-only.   Current window size.
    ImVec2  DesiredSize;    // Read-write.  Desired size, based on user's mouse position. Write to this field to restrain resizing.
}

// Helpers macros to generate 32-bits encoded colors
version( IMGUI_USE_BGRA_PACKED_COLOR ) {
    enum IM_COL32_R_SHIFT = 16;
    enum IM_COL32_G_SHIFT = 8;
    enum IM_COL32_B_SHIFT = 0;
    enum IM_COL32_A_SHIFT = 24;
    enum IM_COL32_A_MASK  = 0xFF000000;
} else {
    enum IM_COL32_R_SHIFT = 0;
    enum IM_COL32_G_SHIFT = 8;
    enum IM_COL32_B_SHIFT = 16;
    enum IM_COL32_A_SHIFT = 24;
    enum IM_COL32_A_MASK  = 0xFF000000;
}
ImU32 IM_COL32( ImU32 R, ImU32 G, ImU32 B, ImU32 A ) { return ( A << IM_COL32_A_SHIFT ) | ( B << IM_COL32_B_SHIFT ) | ( G << IM_COL32_G_SHIFT ) | ( R << IM_COL32_R_SHIFT ); }
ImU32 IM_COL32_WHITE()       { return IM_COL32( 255, 255, 255, 255 ); }  // Opaque white
ImU32 IM_COL32_BLACK()       { return IM_COL32( 0, 0, 0, 255 ); }        // Opaque black
ImU32 IM_COL32_BLACK_TRANS() { return IM_COL32( 0, 0, 0, 0 ); }          // Transparent black

// ImColor() helper to implicity converts colors to either ImU32 ( packed 4x1 byte ) or ImVec4 ( 4x1 float )
// Prefer using IM_COL32() macros if you want a guaranteed compile-time ImU32 for usage with ImDrawList API.
// **Avoid storing ImColor! Store either u32 of ImVec4. This is not a full-featured color class.
// **None of the ImGui API are using ImColor directly but you can use it as a convenience to pass colors in either ImU32 or ImVec4 formats.
struct ImColor
{
    ImVec4              Value = ImVec4( 0, 0, 0, 0 );

    //this()                                                    { Value.x = Value.y = Value.z = Value.w = 0.0f; }
    this( int r, int g, int b, int a = 255 )                    { float sc = 1.0f / 255.0f; Value.x = cast( float )r * sc; Value.y = cast( float )g * sc; Value.z = cast( float )b * sc; Value.w = cast( float )a * sc; }
    this( ImU32 rgba )                                          { float sc = 1.0f / 255.0f; Value.x = (( rgba >> IM_COL32_R_SHIFT ) & 0xFF ) * sc; Value.y = (( rgba >> IM_COL32_G_SHIFT ) & 0xFF ) * sc; Value.z = (( rgba >> IM_COL32_B_SHIFT ) & 0xFF ) * sc; Value.w = (( rgba >> IM_COL32_A_SHIFT ) & 0xFF ) * sc; }
    this( float r, float g, float b, float a = 1.0f )           { Value.x = r; Value.y = g; Value.z = b; Value.w = a; }
    this( const ref ImVec4 col )                                { Value = col; }
    ImU32   opCast( T : ImU32 )()                               { return ColorConvertFloat4ToU32( Value ); }
    alias   Value this; //ImVec4 opCast( T : ImVec4 )           { return Value; }
    //float[4]    opCast( float[4] )                              { float[4] result = [ Value.x, Value.y, Value.z, Value.w ]; return result; }
    //float[3]    opCast( float[3] )                              { float[3] result = [ Value.x, Value.y, Value.z          ]; return result; }

    import imgui.funcs_static : ColorConvertHSVtoRGB;
    void   SetHSV( float h, float s, float v, float a = 1.0f )  { ColorConvertHSVtoRGB( h, s, v, Value.x, Value.y, Value.z ); Value.w = a; }
    static ImColor HSV( float h, float s, float v, float a = 1.0f )   { float r, g, b; ColorConvertHSVtoRGB( h, s, v, r, g, b ); return ImColor( r, g, b, a ); }
}

// Helper: Manually clip large list of items.
// If you are submitting lots of evenly spaced items and you have a random access to the list, you can perform coarse clipping based on visibility to save yourself from processing those items at all.
// The clipper calculates the range of visible items and advance the cursor to compensate for the non-visible items we have skipped.
// ImGui already clip items based on their bounds but it needs to measure text size to do so. Coarse clipping before submission makes this cost and your own data fetching/submission cost null.
// Usage:
//     ImGuiListClipper clipper( 1000 );  // we have 1000 elements, evenly spaced.
//     while ( clipper.Step())
//         for ( int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++ )
//             ImGui::Text( "line number %d", i );
// - Step 0: the clipper let you process the first element, regardless of it being visible or not, so we can measure the element height ( step skipped if we passed a known height as second arg to constructor ).
// - Step 1: the clipper infer height from first element, calculate the actual range of elements to display, and position the cursor before the first element.
// - ( Step 2: dummy step only required if an explicit items_height was passed to constructor or Begin() and user call Step(). Does nothing and switch to Step 3. )
// - Step 3: the clipper validate that we have reached the expected Y position ( corresponding to element DisplayEnd ), advance the cursor to the end of the list and then returns 'false' to end the loop.
struct ImGuiListClipper
{
    float   StartPosY;
    float   ItemsHeight = 0;
    int     ItemsCount = -1, StepNo, DisplayStart, DisplayEnd;

    // items_count:  Use -1 to ignore ( you can call Begin later ). Use INT_MAX if you don't know how many items you have ( in which case the cursor won't be advanced in the final step ).
    // items_height: Use -1.0f to be calculated automatically on first step. Otherwise pass in the distance between your items, typically GetTextLineHeightWithSpacing() or GetItemsLineHeightWithSpacing().
    // If you don't specify an items_height, you NEED to call Step(). If you specify items_height you may call the old Begin()/End() api directly, but prefer calling Step().
    this( int items_count, float items_height = -1.0f )     { Begin( items_count, items_height ); } // NB: Begin() initialize every fields ( as we allow user to call Begin/End multiple times on a same instance if they want ).
    ~this()                                                 { IM_ASSERT( ItemsCount == -1 ); }      // Assert if user forgot to call End() or Step() until false.

    bool Step();                                              // Call until it returns false. The DisplayStart/DisplayEnd fields will be set and you can process/draw those items.
    void Begin( int items_count, float items_height = -1.0f );  // Automatically called by constructor if you passed 'items_count' or by Step() in Step 1.
    void End();                                               // Automatically called on the last call of Step() that returns false.
}

//-----------------------------------------------------------------------------
// Draw List
// Hold a series of drawing commands. The user provides a renderer for ImDrawData which essentially contains an array of ImDrawList.
//-----------------------------------------------------------------------------

// Draw callbacks for advanced uses.
// NB- You most likely do NOT need to use draw callbacks just to create your own widget or customized UI rendering ( you can poke into the draw list for that )
// Draw callback may be useful for example, A ) Change your GPU render state, B ) render a complex 3D scene inside a UI element ( without an intermediate texture/render target ), etc.
// The expected behavior from your rendering function is 'if( cmd.UserCallback != null ) cmd.UserCallback( parent_list, cmd ); else RenderTriangles()'
alias ImDrawCallback = void function( const ImDrawList* parent_list, const ImDrawCmd* cmd ) nothrow;

// Typically, 1 command = 1 gpu draw call ( unless command is a callback )
struct ImDrawCmd
{
    uint            ElemCount = 0;              // Number of indices ( multiple of 3 ) to be rendered as triangles. Vertices are stored in the callee ImDrawList's vtx_buffer[] array, indices in idx_buffer[].
    ImVec4          ClipRect  = ImVec4( -8192.0f, -8192.0f, 8192.0f, 8192.0f );  // Clipping rectangle ( x1, y1, x2, y2 )
    ImTextureID     TextureId = null;           // User-provided texture ID. Set by user in ImfontAtlas::SetTexID() for fonts or passed to Image*() functions. Ignore if never using images or multiple fonts atlas.
    ImDrawCallback  UserCallback = null;        // If != null, call the function instead of rendering the vertices. clip_rect and texture_id will be set normally.
    void*           UserCallbackData = null;    // The draw callback code can access this.

    //ImDrawCmd() { ElemCount = 0; ClipRect.x = ClipRect.y = -8192.0f; ClipRect.z = ClipRect.w = +8192.0f; TextureId = null; UserCallback = null; UserCallbackData = null; }
}

// Vertex index ( override with '#define ImDrawIdx unsigned int' inside in imconfig.h )
version( USER_DRAW_IDX ) {} // #ifndef ImDrawIdx
else alias ushort ImDrawIdx;
//#endif

// Vertex layout
//#ifndef IMGUI_OVERRIDE_DRAWVERT_STRUCT_LAYOUT
struct ImDrawVert
{
    ImVec2  pos;
    ImVec2  uv;
    ImU32   col;
}
//#else
// You can override the vertex format layout by defining IMGUI_OVERRIDE_DRAWVERT_STRUCT_LAYOUT in imconfig.h
// The code expect ImVec2 pos ( 8 bytes ), ImVec2 uv ( 8 bytes ), ImU32 col ( 4 bytes ), but you can re-order them or add other fields as needed to simplify integration in your engine.
// The type has to be described within the macro ( you can either declare the struct or use a typedef )
//IMGUI_OVERRIDE_DRAWVERT_STRUCT_LAYOUT;
//#endif

// Draw channels are used by the Columns API to "split" the render list into different channels while building, so items of each column can be batched together.
// You can also use them to simulate drawing layers and submit primitives in a different order than how they will be rendered.
struct ImDrawChannel
{
    ImVector!ImDrawCmd      CmdBuffer;
    ImVector!ImDrawIdx      IdxBuffer;
}

// Draw command list
// This is the low-level list of polygons that ImGui functions are filling. At the end of the frame, all command lists are passed to your ImGuiIO::RenderDrawListFn function for rendering.
// At the moment, each ImGui window contains its own ImDrawList but they could potentially be merged in the future.
// If you want to add custom rendering within a window, you can use ImGui::GetWindowDrawList() to access the current draw list and add your own primitives.
// You can interleave normal ImGui:: calls and adding primitives to the current draw list.
// All positions are in screen coordinates ( 0,0=top-left, 1 pixel per unit ). Primitives are always added to the list and not culled ( culling is done at render time and at a higher-level by ImGui:: functions ).
struct ImDrawList
{
    // This is what you have to render
    ImVector!ImDrawCmd      CmdBuffer;          // Commands. Typically 1 command = 1 gpu draw call.
    ImVector!ImDrawIdx      IdxBuffer;          // Index buffer. Each command consume ImDrawCmd::ElemCount of those
    ImVector!ImDrawVert     VtxBuffer;          // Vertex buffer.

    // [Internal, used while building lists]
    const(char)*            _OwnerName;         // Pointer to owner window's name for debugging
    uint                    _VtxCurrentIdx;     // [Internal] == VtxBuffer.Size
    ImDrawVert*             _VtxWritePtr;       // [Internal] point within VtxBuffer.Data after each add command ( to avoid using the ImVector<> operators too much )
    ImDrawIdx*              _IdxWritePtr;       // [Internal] point within IdxBuffer.Data after each add command ( to avoid using the ImVector<> operators too much )
    ImVector!ImVec4         _ClipRectStack;     // [Internal]
    ImVector!ImTextureID    _TextureIdStack;    // [Internal]
    ImVector!ImVec2         _Path;              // [Internal] current path building
    int                     _ChannelsCurrent;   // [Internal] current channel number ( 0 )
    int                     _ChannelsCount;     // [Internal] number of active channels ( 1+ )
    ImVector!ImDrawChannel  _Channels;          // [Internal] draw channels for columns API ( not resized down so _ChannelsCount may be smaller than _Channels.Size )

    //ImDrawList()  { _OwnerName = null; Clear(); }
    //~this() { ClearFreeMemory(); }
    void  PushClipRect( ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect = false );  // Render-level scissoring. This is passed down to your render function but not used for CPU-side coarse clipping. Prefer using higher-level ImGui::PushClipRect() to affect logic ( hit-testing and widget culling )
    void  PushClipRectFullScreen();
    void  PopClipRect();
    void  PushTextureID( const ref ImTextureID texture_id );
    void  PopTextureID();

    // Primitives
    void  AddLine( const ref ImVec2 a, const ref ImVec2 b, ImU32 col, float thickness = 1.0f );
    void  AddRect( const ref ImVec2 a, const ref ImVec2 b, ImU32 col, float rounding = 0.0f, int rounding_corners_flags = ~0, float thickness = 1.0f );   // a: upper-left, b: lower-right, rounding_corners_flags: 4-bits corresponding to which corner to round
    void  AddRectFilled( const ref ImVec2 a, const ref ImVec2 b, ImU32 col, float rounding = 0.0f, int rounding_corners_flags = ~0 );                     // a: upper-left, b: lower-right
    void  AddRectFilledMultiColor( const ref ImVec2 a, const ref ImVec2 b, ImU32 col_upr_left, ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left );
    void  AddQuad( const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 c, const ref ImVec2 d, ImU32 col, float thickness = 1.0f );
    void  AddQuadFilled( const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 c, const ref ImVec2 d, ImU32 col );
    void  AddTriangle( const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 c, ImU32 col, float thickness = 1.0f );
    void  AddTriangleFilled( const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 c, ImU32 col );
    void  AddCircle( const ref ImVec2 centre, float radius, ImU32 col, int num_segments = 12, float thickness = 1.0f );
    void  AddCircleFilled( const ref ImVec2 centre, float radius, ImU32 col, int num_segments = 12 );
    void  AddText( const ref ImVec2 pos, ImU32 col, const(char)* text_begin, const(char)* text_end = null );
    void  AddText( const ImFont* font, float font_size, const ref ImVec2 pos, ImU32 col, const(char)* text_begin, const(char)* text_end = null, float wrap_width = 0.0f, const ImVec4* cpu_fine_clip_rect = null );
    void  AddImage( ImTextureID user_texture_id, const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 uv0, const ref ImVec2 uv1, ImU32 col = 0xFFFFFFFF );
    void  AddImage( ImTextureID user_texture_id, const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 uv0 ) { ImVec2 uv1 = ImVec2( 1, 1 ); AddImage( user_texture_id, a, b, uv0, uv1, 0xFFFFFFFF ); }
    void  AddImage( ImTextureID user_texture_id, const ref ImVec2 a, const ref ImVec2 b ) { ImVec2 uv0 = ImVec2( 0, 0 ), uv1 = ImVec2( 1, 1 ); AddImage( user_texture_id, a, b, uv0, uv1, 0xFFFFFFFF ); }
    void  AddImageQuad( ImTextureID user_texture_id, const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 c, const ref ImVec2 d, const ref ImVec2 uv_a /*= ImVec2(0,0)*/, const ref ImVec2 uv_b /*= ImVec2(1,0)*/, const ref ImVec2 uv_c /*= ImVec2(1,1)*/, const ref ImVec2 uv_d /*= ImVec2(0,1)*/, ImU32 col /*= 0xFFFFFFFF*/ );
    void  AddPolyline( const ImVec2* points, const int num_points, ImU32 col, bool closed, float thickness, bool anti_aliased );
    void  AddConvexPolyFilled( const ImVec2* points, const int num_points, ImU32 col, bool anti_aliased );
    void  AddBezierCurve( const ref ImVec2 pos0, const ref ImVec2 cp0, const ref ImVec2 cp1, const ref ImVec2 pos1, ImU32 col, float thickness, int num_segments = 0 );

    // Stateful path API, add points then finish with PathFill() or PathStroke()
    void  PathClear()                                                   ;//{ _Path.resize( 0 ); }
    void  PathLineTo( const ref ImVec2 pos )                            ;//{ _Path.push_back( pos ); }
    void  PathLineToMergeDuplicate( const ref ImVec2 pos )              ;//{ if( _Path.Size == 0 || memcmp( &_Path[ _Path.Size-1 ], pos, 8 ) != 0 ) _Path.push_back( pos ); }
    void  PathFillConvex( ImU32 col )                                   ;//{ AddConvexPolyFilled( _Path.Data, _Path.Size, col, true ); PathClear(); }
    void  PathStroke( ImU32 col, bool closed, float thickness = 1.0f )  ;//{ AddPolyline( _Path.Data, _Path.Size, col, closed, thickness, true ); PathClear(); }
    void  PathArcTo( const ref ImVec2 centre, float radius, float a_min, float a_max, int num_segments = 10 );
    void  PathArcToFast( const ref ImVec2 centre, float radius, int a_min_of_12, int a_max_of_12 );                                // Use precomputed angles for a 12 steps circle
    void  PathBezierCurveTo( const ref ImVec2 p1, const ref ImVec2 p2, const ref ImVec2 p3, int num_segments = 0 );
    void  PathRect( const ref ImVec2 rect_min, const ref ImVec2 rect_max, float rounding = 0.0f, int rounding_corners_flags = ~0 );   // rounding_corners_flags: 4-bits corresponding to which corner to round

    // Channels
    // - Use to simulate layers. By switching channels to can render out-of-order ( e.g. submit foreground primitives before background primitives )
    // - Use to minimize draw calls ( e.g. if going back-and-forth between multiple non-overlapping clipping rectangles, prefer to append into separate channels then merge at the end )
    void  ChannelsSplit( int channels_count );
    void  ChannelsMerge();
    void  ChannelsSetCurrent( int channel_index );

    // Advanced
    void  AddCallback( ImDrawCallback callback, void* callback_data );  // Your rendering function must check for 'UserCallback' in ImDrawCmd and call the function instead of rendering triangles.
    void  AddDrawCmd();                                               // This is useful if you need to forcefully create a new draw call ( to allow for dependent rendering / blending ). Otherwise primitives are merged into the same draw-call as much as possible

    // Internal helpers
    // NB: all primitives needs to be reserved via PrimReserve() beforehand!
    void  Clear();
    void  ClearFreeMemory();
    void  PrimReserve( int idx_count, int vtx_count );
    void  PrimRect( const ref ImVec2 a, const ref ImVec2 b, ImU32 col );      // Axis aligned rectangle ( composed of two triangles )
    void  PrimRectUV( const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 uv_a, const ref ImVec2 uv_b, ImU32 col );
    void  PrimQuadUV( const ref ImVec2 a, const ref ImVec2 b, const ref ImVec2 c, const ref ImVec2 d, const ref ImVec2 uv_a, const ref ImVec2 uv_b, const ref ImVec2 uv_c, const ref ImVec2 uv_d, ImU32 col );
    void  PrimWriteVtx( const ref ImVec2 pos, const ref ImVec2 uv, ImU32 col )  { _VtxWritePtr.pos = pos; _VtxWritePtr.uv = uv; _VtxWritePtr.col = col; _VtxWritePtr++; _VtxCurrentIdx++; }
    void  PrimWriteIdx( ImDrawIdx idx )                                         { *_IdxWritePtr = idx; _IdxWritePtr++; }
    void  PrimVtx( const ref ImVec2 pos, const ref ImVec2 uv, ImU32 col )       { PrimWriteIdx( cast( ImDrawIdx )_VtxCurrentIdx ); PrimWriteVtx( pos, uv, col ); }
    void  UpdateClipRect();
    void  UpdateTextureID();
}

// All draw data to render an ImGui frame
struct ImDrawData
{
    bool            Valid;                      // Only valid after Render() is called and before the next NewFrame() is called.
    ImDrawList**    CmdLists;
    int             CmdListsCount;
    int             TotalVtxCount;              // For convenience, sum of all cmd_lists vtx_buffer.Size
    int             TotalIdxCount;              // For convenience, sum of all cmd_lists idx_buffer.Size

    // Functions
    //ImDrawData() { Valid = false; CmdLists = null; CmdListsCount = TotalVtxCount = TotalIdxCount = 0; }
    void DeIndexAllBuffers();                   // For backward compatibility: convert all buffers from indexed to de-indexed, in case you cannot render indexed. Note: this is slow and most likely a waste of resources. Always prefer indexed rendering!
    void ScaleClipRects( const ref ImVec2 sc ); // Helper to scale the ClipRect field of each ImDrawCmd. Use if your final output buffer is at a different scale than ImGui expects, or if there is a difference between your window resolution and framebuffer resolution.
}

struct ImFontConfig
{
    void*           FontData;                               // TTF data
    int             FontDataSize;                           // TTF data size
    bool            FontDataOwnedByAtlas = true;            // TTF data ownership taken by the container ImFontAtlas ( will delete memory itself ). Set to true
    int             FontNo;                                 // Index of font within TTF file
    float           SizePixels;                             // Size in pixels for rasterizer
    int             OversampleH = 3, OversampleV = 1;       // Rasterize at higher quality for sub-pixel positioning. We don't use sub-pixel positions on the Y axis.
    bool            PixelSnapH = false;                     // Align every glyph to pixel boundary. Useful e.g. if you are merging a non-pixel aligned font with the default font. If enabled, you can set OversampleH/V to 1.
    ImVec2          GlyphExtraSpacing = ImVec2( 0, 0 );     // Extra spacing ( in pixels ) between glyphs
    const(ImWchar)* GlyphRanges;                            // Pointer to a user-provided list of Unicode range ( 2 value per range, values are inclusive, zero-terminated list ). THE ARRAY DATA NEEDS TO PERSIST AS LONG AS THE FONT IS ALIVE.
    bool            MergeMode = false;                      // Merge into previous ImFont, so you can combine multiple inputs font into one ImFont ( e.g. ASCII font + icons + Japanese glyphs ).
    bool            MergeGlyphCenterV = false;              // When merging ( multiple ImFontInput for one ImFont ), vertically center new glyphs instead of aligning their baseline

    // [Internal]
    char[32]        Name;                                   // Name ( strictly for debugging )
    ImFont*         DstFont;

    //ImFontConfig();
}

// Load and rasterize multiple TTF fonts into a same texture.
// Sharing a texture for multiple fonts allows us to reduce the number of draw calls during rendering.
// We also add custom graphic data into the texture that serves for ImGui.
//  1. ( Optional ) Call AddFont*** functions. If you don't call any, the default font will be loaded for you.
//  2. Call GetTexDataAsAlpha8() or GetTexDataAsRGBA32() to build and retrieve pixels data.
//  3. Upload the pixels data into a texture within your graphics system.
//  4. Call SetTexID( my_tex_id ); and pass the pointer/identifier to your texture. This value will be passed back to you during rendering to identify the texture.
//  5. Call ClearTexData() to free textures memory on the heap.
// NB: If you use a 'glyph_ranges' array you need to make sure that your array persist up until the ImFont is cleared. We only copy the pointer, not the data.
struct ImFontAtlas
{
    //ImFontAtlas();
    //~ImFontAtlas();
    ImFont*         AddFont( const( ImFontConfig )* font_cfg );
    ImFont*         AddFontDefault( const( ImFontConfig )* font_cfg = null );
    ImFont*         AddFontFromFileTTF( const(char)* filename, float size_pixels, const( ImFontConfig )* font_cfg = null, const( ImWchar )* glyph_ranges = null );
    ImFont*         AddFontFromMemoryTTF( void* ttf_data, int ttf_size, float size_pixels, const( ImFontConfig )* font_cfg = null, const( ImWchar )* glyph_ranges = null );                                        // Transfer ownership of 'ttf_data' to ImFontAtlas, will be deleted after Build()
    ImFont*         AddFontFromMemoryCompressedTTF( const void* compressed_ttf_data, int compressed_ttf_size, float size_pixels, const( ImFontConfig )* font_cfg = null, const( ImWchar )* glyph_ranges = null );  // 'compressed_ttf_data' still owned by caller. Compress with binary_to_compressed_c.cpp
    ImFont*         AddFontFromMemoryCompressedBase85TTF( const(char)* compressed_ttf_data_base85, float size_pixels, const( ImFontConfig )* font_cfg = null, const( ImWchar )* glyph_ranges = null );              // 'compressed_ttf_data_base85' still owned by caller. Compress with binary_to_compressed_c.cpp with -base85 paramaeter
    void            ClearTexData();             // Clear the CPU-side texture data. Saves RAM once the texture has been copied to graphics memory.
    void            ClearInputData();           // Clear the input TTF data ( inc sizes, glyph ranges )
    void            ClearFonts();               // Clear the ImGui-side font data ( glyphs storage, UV coordinates )
    void            Clear();                    // Clear all

    // Retrieve texture data
    // User is in charge of copying the pixels into graphics memory, then call SetTextureUserID()
    // After loading the texture into your graphic system, store your texture handle in 'TexID' ( ignore if you aren't using multiple fonts nor images )
    // RGBA32 format is provided for convenience and high compatibility, but note that all RGB pixels are white, so 75% of the memory is wasted.
    // Pitch = Width * BytesPerPixels
    void            GetTexDataAsAlpha8( ubyte** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel = null );  // 1 byte per-pixel
    void            GetTexDataAsRGBA32( ubyte** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel = null );  // 4 bytes-per-pixel
    void            SetTexID( void* id )  { TexID = id; }

    // Helpers to retrieve list of common Unicode ranges ( 2 value per range, values are inclusive, zero-terminated list )
    // NB: Make sure that your string are UTF-8 and NOT in your local code page. See FAQ for details.
    const(ImWchar)* GetGlyphRangesDefault();    // Basic Latin, Extended Latin
    const(ImWchar)* GetGlyphRangesKorean();     // Default + Korean characters
    const(ImWchar)* GetGlyphRangesJapanese();   // Default + Hiragana, Katakana, Half-Width, Selection of 1946 Ideographs
    const(ImWchar)* GetGlyphRangesChinese();    // Japanese + full set of about 21000 CJK Unified Ideographs
    const(ImWchar)* GetGlyphRangesCyrillic();   // Default + about 400 Cyrillic characters
    const(ImWchar)* GetGlyphRangesThai();       // Default + Thai characters

    // Members
    // ( Access texture data via GetTexData*() calls which will setup a default font for you. )
    void*                   TexID;              // User data to refer to the texture once it has been uploaded to user's graphic systems. It ia passed back to you during rendering.
    ubyte*                  TexPixelsAlpha8;    // 1 component per pixel, each component is unsigned 8-bit. Total size = TexWidth * TexHeight
    uint*                   TexPixelsRGBA32;    // 4 component per pixel, each component is unsigned 8-bit. Total size = TexWidth * TexHeight * 4
    int                     TexWidth;           // Texture width calculated during Build().
    int                     TexHeight;          // Texture height calculated during Build().
    int                     TexDesiredWidth;    // Texture width desired by user before Build(). Must be a power-of-two. If have many glyphs your graphics API have texture size restrictions you may want to increase texture width to decrease height.
    ImVec2                  TexUvWhitePixel;    // Texture coordinates to a white pixel
    ImVector!( ImFont* )    Fonts;              // Hold all the fonts returned by AddFont*. Fonts[0] is the default font upon calling ImGui::NewFrame(), use ImGui::PushFont()/PopFont() to change the current font.

    // Private
    ImVector!ImFontConfig   ConfigData;         // Internal data
    bool                    Build();            // Build pixels data. This is automatically for you by the GetTexData*** functions.
    void                    RenderCustomTexData( int pass, void* rects );
}

// Font runtime data and rendering
// ImFontAtlas automatically loads a default embedded font for you when you call GetTexDataAsAlpha8() or GetTexDataAsRGBA32().
struct ImFont
{
    struct Glyph
    {
        ImWchar     Codepoint;
        float       XAdvance;
        float       X0, Y0, X1, Y1;
        float       U0, V0, U1, V1;     // Texture coordinates
    }

    // Members: Hot ~62/78 bytes
    float           FontSize;           // <user set>   // Height of characters, set during loading ( don't change after loading )
    float           Scale;              // = 1.f        // Base font scale, multiplied by the per-window font scale which you can adjust with SetFontScale()
    ImVec2          DisplayOffset;      // = ( 0.f,1.f )  // Offset font rendering by xx pixels
    ImVector!Glyph  Glyphs;             //              // All glyphs.
    ImVector!float  IndexXAdvance;      //              // Sparse. Glyphs.XAdvance in a directly indexable way ( more cache-friendly, for CalcTextSize functions which are often bottleneck in large UI ).
    ImVector!ushort IndexLookup;        //              // Sparse. Index glyphs by Unicode code-point.
    const( Glyph )* FallbackGlyph;      // == FindGlyph( FontFallbackChar )
    float           FallbackXAdvance;   // == FallbackGlyph.XAdvance
    ImWchar         FallbackChar;       // = '?'        // Replacement glyph if one isn't found. Only set via SetFallbackChar()

    // Members: Cold ~18/26 bytes
    short           ConfigDataCount;    // ~ 1          // Number of ImFontConfig involved in creating this font. Bigger than 1 when merging multiple font sources into one ImFont.
    ImFontConfig*   ConfigData;         //              // Pointer within ContainerAtlas.ConfigData
    ImFontAtlas*    ContainerAtlas;     //              // What we has been loaded into
    float           Ascent, Descent;    //              // Ascent: distance from top to bottom of e.g. 'A' [0..FontSize]
    int             MetricsTotalSurface;//              // Total surface in pixels to get an idea of the font rasterization/texture cost ( not exact, we approximate the cost of padding between glyphs )

    // Methods
    //ImFont();
    //~ImFont();
    void            Clear();
    void            BuildLookupTable();
    const( Glyph )* FindGlyph( ImWchar c );
    void            SetFallbackChar( ImWchar c );
    float           GetCharAdvance( ImWchar c )     ;//{ return ( cast( int )c < IndexXAdvance.Size ) ? IndexXAdvance[ cast( int )c ] : FallbackXAdvance; }
    bool            IsLoaded() const                ;//{ return ContainerAtlas != null; }

    // 'max_width' stops rendering after a certain width ( could be turned into a 2d size ). FLT_MAX to disable.
    // 'wrap_width' enable automatic word-wrapping across multiple lines to fit into given width. 0.0f to disable.
    ImVec2          CalcTextSizeA( float size, float max_width, float wrap_width, const(char)* text_begin, const(char)* text_end = null, const(char)** remaining = null ) const; // utf8
    const(char)*    CalcWordWrapPositionA( float scale, const(char)* text, const(char)* text_end, float wrap_width );
    void            RenderChar( ImDrawList* draw_list, float size, ImVec2 pos, ImU32 col, ushort c );
    void            RenderText( ImDrawList* draw_list, float size, ImVec2 pos, ImU32 col, const ref ImVec4 clip_rect, const(char)* text_begin, const(char)* text_end, float wrap_width = 0.0f, bool cpu_fine_clip = false );

    // Private
    void            GrowIndex( int new_size );
    void            AddRemapChar( ImWchar dst, ImWchar src, bool overwrite_dst = true ); // Makes 'dst' character/glyph points to 'src' character/glyph. Currently needs to be called AFTER fonts have been built.
}

//#if defined( __clang__ )
//#pragma clang diagnostic pop
//#endif

// Include imgui_user.h at the end of imgui.h ( convenient for user to only explicitly include vanilla imgui.h )
//#ifdef IMGUI_INCLUDE_IMGUI_USER_H
//#include "imgui_user.h"
//#endif
