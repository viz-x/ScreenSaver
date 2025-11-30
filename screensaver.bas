' Retro Screensaver in FreeBASIC
' A nostalgic animated screen experience

' Open graphics window (GDI on Windows, console on Linux)
ScreenRes 640, 480, 32

' Global variables
Dim Shared As Integer x, y, mode
Dim Shared As Double last_mode_change

' Initialize random seed
Randomize Timer

' Initialize stars array (0 to 99, 0 to 2)
Dim Shared stars(0 To 99, 0 To 2) As Double

' Initialize stars for star field mode
Sub init_stars()
    Dim i As Integer
    For i = 0 To 99
        stars(i, 0) = Rnd * 640   ' X coordinate
        stars(i, 1) = Rnd * 480   ' Y coordinate
        stars(i, 2) = Rnd * 15    ' Brightness
    Next i
End Sub

' Draw star field mode
Sub draw_stars()
    Dim i As Integer
    Cls
    For i = 0 To 99
        ' Move stars downward
        stars(i, 1) = stars(i, 1) + 5
        
        ' Wrap around if star goes off screen
        If stars(i, 1) > 480 Then
            stars(i, 1) = 0
            stars(i, 0) = Rnd * 640
        End If
        
        ' Draw star with brightness variation
        Dim brightness As Integer = 16 + Int(stars(i, 2) * 15)
        Circle (stars(i, 0), stars(i, 1)), 2, RGB(brightness * 16, brightness * 16, brightness * 16), , , , F
    Next i
End Sub

' Bouncing text mode
Sub draw_bouncing_text()
    Dim tx As Double, ty As Double
    Cls
    
    ' Oscillate text position
    tx = 320 + Sin(Timer * 2) * 200
    ty = 240 + Cos(Timer * 2) * 100
    
    ' Draw retro text
    Draw String (tx, ty), "RETRO MODE", RGB(0, 255, 0)
End Sub

' Geometric trail mode
Sub draw_geometric_trail()
    Dim i As Integer
    Cls
    
    ' Create moving geometric patterns
    For i = 0 To 10
        Dim x1 As Integer = Rnd * 640
        Dim y1 As Integer = Rnd * 480
        Dim x2 As Integer = Rnd * 640
        Dim y2 As Integer = Rnd * 480
        Dim r As Integer = Rnd * 255
        Dim g As Integer = Rnd * 255
        Dim b As Integer = Rnd * 255
        Line (x1, y1)-(x2, y2), RGB(r, g, b)
    Next i
End Sub

' Main animation loop
Sub main_animation()
    Dim k As String
    Dim current_time As Double
    
    ' Initialize modes
    init_stars()
    mode = 0
    last_mode_change = Timer
    
    ' Infinite animation loop
    Do
        ' Get current time
        current_time = Timer
        
        ' Auto mode switch every 10 seconds
        If current_time - last_mode_change > 10 Then
            mode = (mode + 1) Mod 3
            last_mode_change = current_time
        End If
        
        ' Select and draw current mode
        Select Case mode
            Case 0
                draw_stars()
            Case 1
                draw_bouncing_text()
            Case 2
                draw_geometric_trail()
        End Select
        
        ' Pause to control animation speed
        Sleep 100
        
        ' Check for key press to manually change mode or exit
        k = Inkey
        If k <> "" Then
            If UCase(k) = "Q" Then
                Exit Do
            Else
                mode = (mode + 1) Mod 3
            End If
        End If
    Loop
End Sub

' Program start
main_animation()

' End program
End