Imports System.Drawing.Drawing2D
Imports System.Runtime.InteropServices
Imports System.Threading

Public Class ver
    Dim fun As New funcoes
    Public Const WM_NCLBUTTONDOWN As Integer = &HA1
    Public Const HT_CAPTION As Integer = 2

    <DllImport("user32.dll")>
    Public Shared Function SendMessage(hWnd As IntPtr, Msg As Integer, wParam As Integer, lParam As Integer) As Integer
    End Function

    <DllImport("user32.dll")>
    Public Shared Function ReleaseCapture() As Boolean
    End Function

    Dim listaexibida As New Dictionary(Of String, DadoInfo)

    Private BorderThickness As Integer = 5
    Public Sub New()
        InitializeComponent()

        Me.SetStyle(ControlStyles.OptimizedDoubleBuffer, True)
        Me.SetStyle(ControlStyles.ResizeRedraw, True)
        Me.SetStyle(ControlStyles.AllPaintingInWmPaint, True)
        Me.SetStyle(ControlStyles.UserPaint, True)
    End Sub
    Private Sub Label1_Click(sender As Object, e As EventArgs) Handles Label1.Click



    End Sub

    Private Sub Label2_Click(sender As Object, e As EventArgs) Handles Label2.Click

    End Sub

    Private Sub ver_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        fun.AplicarBordasRedondas(30, Me)

        Me.Text = fun.cortartexto(Selecionado.Mensagem, 18)
        UrbEcoReportsToolStripMenuItem.Text = $"Detalhes - {fun.cortartexto(Selecionado.Mensagem, 18)}"
        Label1.Text = Selecionado.Assunto
        Label2.Text = Selecionado.Nome
        Label3.Text = Selecionado.Email
        RichTextBox1.Text = Selecionado.Mensagem
        CheckBox1.Checked = Selecionado.Finalizado.ToLower = "true"
    End Sub

    Private Sub ToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItem1.Click
        Me.WindowState = FormWindowState.Minimized
    End Sub

    Private Sub ver_Resize(sender As Object, e As EventArgs) Handles MyBase.Resize
        fun.AplicarBordasRedondas(30, Me)
    End Sub

    Private Sub XToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles XToolStripMenuItem.Click
        Me.Close()
    End Sub

    Private Sub MenuStrip1_MouseDown(sender As Object, e As MouseEventArgs) Handles MenuStrip1.MouseDown
        If e.Button = MouseButtons.Left Then
            ReleaseCapture()
            SendMessage(Me.Handle, WM_NCLBUTTONDOWN, HT_CAPTION, 0)
        End If
    End Sub

    Private Async Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Selecionado.Finalizado = If(CheckBox1.Checked, "true", "false")
        Await fun.EditarMensagem(Selecionado.Id, Selecionado)
        MsgBox("Status salvo com sucesso!")
    End Sub

    Private Async Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Await fun.DeletarMensagem(Selecionado.Id)
        MsgBox("Deletado salvo com sucesso!")
    End Sub

    Protected Overrides Sub OnPaint(ByVal e As PaintEventArgs)
        MyBase.OnPaint(e)
        Dim g As Graphics = e.Graphics
        g.SmoothingMode = SmoothingMode.HighQuality
        Dim rectForm As New Rectangle(0, 0, Me.Width, Me.Height)
        If (Selecionado.Finalizado = "true") Then
            Using brush As New LinearGradientBrush(rectForm, Color.SpringGreen, Color.SeaGreen, 45.0F)
                Using pen As New Pen(brush, BorderThickness)
                    pen.Alignment = PenAlignment.Inset
                    g.DrawRectangle(pen, rectForm)
                End Using
            End Using
        End If
        If (Selecionado.Finalizado = "false") Then
            Using brush As New LinearGradientBrush(rectForm, Color.PaleVioletRed, Color.DarkRed, 45.0F)
                Using pen As New Pen(brush, BorderThickness)
                    pen.Alignment = PenAlignment.Inset
                    g.DrawRectangle(pen, rectForm)
                End Using
            End Using
        End If
    End Sub
End Class