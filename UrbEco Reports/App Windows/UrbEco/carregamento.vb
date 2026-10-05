Imports System.Drawing.Drawing2D
Imports System.Reflection.Emit
Imports System.Runtime.InteropServices

Public Class carregamento
    Dim fun As New funcoes
    Public Const WM_NCLBUTTONDOWN As Integer = &HA1
    Public Const HT_CAPTION As Integer = 2

    <DllImport("user32.dll")>
    Public Shared Function SendMessage(hWnd As IntPtr, Msg As Integer, wParam As Integer, lParam As Integer) As Integer
    End Function

    <DllImport("user32.dll")>
    Public Shared Function ReleaseCapture() As Boolean
    End Function
    Private BorderThickness As Integer = 5
    Public Sub New()
        InitializeComponent()

        Me.SetStyle(ControlStyles.OptimizedDoubleBuffer, True)
        Me.SetStyle(ControlStyles.ResizeRedraw, True)
        Me.SetStyle(ControlStyles.AllPaintingInWmPaint, True)
        Me.SetStyle(ControlStyles.UserPaint, True)
    End Sub

    Private Async Sub carregamento_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        fun.AplicarBordasRedondas(30, Me)
        Label1.Text = Nothing
        Label2.Text = Nothing
        For i = 0 To "UrbEco".Length
            Label1.Text = "UrbEco".Substring(0, i)
            Await Task.Delay(125)
        Next
        For i = 0 To "Reports".Length
            Label2.Text = "Reports".Substring(0, i)
            Await Task.Delay(125)
        Next
        Await Task.Delay(1000)
        For i = 10 To 100
            Me.Opacity = 1 - (i / 100)
            'MsgBox(1)
            Await Task.Delay(15)
        Next
        Form1.Show()
        Await Task.Delay(1000)
        Me.Hide()
    End Sub

    Private Sub carregamento_MouseDown(sender As Object, e As MouseEventArgs) Handles MyBase.MouseDown
        If e.Button = MouseButtons.Left Then
            ReleaseCapture()
            SendMessage(Me.Handle, WM_NCLBUTTONDOWN, HT_CAPTION, 0)
        End If
    End Sub

    Protected Overrides Sub OnPaint(ByVal e As PaintEventArgs)
        MyBase.OnPaint(e)
        Dim g As Graphics = e.Graphics
        g.SmoothingMode = SmoothingMode.HighQuality
        Dim rectForm As New Rectangle(0, 0, Me.Width, Me.Height)
        Using brush As New LinearGradientBrush(rectForm, Color.SpringGreen, Color.SeaGreen, 45.0F)
            Using pen As New Pen(brush, BorderThickness)
                pen.Alignment = PenAlignment.Inset
                g.DrawRectangle(pen, rectForm)
            End Using
        End Using
    End Sub
End Class