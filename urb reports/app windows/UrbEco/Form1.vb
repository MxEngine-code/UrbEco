Imports System.Drawing.Drawing2D
Imports System.Drawing.Drawing2D.GraphicsPath
Imports System.IO
Imports System.Net
Imports System.Runtime.InteropServices
Imports System.Windows.Forms.VisualStyles.VisualStyleElement
Imports FireSharp
Imports FireSharp.Config
Imports FireSharp.Interfaces
Imports FireSharp.Response
Imports Newtonsoft.Json

Public Class Form1
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



    Private Async Sub Recarregar()
        ListBox1.Items.Clear()
        listaexibida.Clear()

        Dim response As FirebaseResponse = Await fun.client.GetAsync("Mensagens")

        If response.Body = "null" Then
            MessageBox.Show("Nenhum registro encontrado.")
            Exit Sub
        End If

        Dim lista As Dictionary(Of String, DadoInfo) = JsonConvert.DeserializeObject(Of Dictionary(Of String, DadoInfo))(response.Body)

        For Each item In lista
            Dim dado As DadoInfo = item.Value
            Dim adicionarItem As Boolean = False

            If ToolStripComboBox1.SelectedIndex = 1 AndAlso dado.Assunto = "Bug" Then
                adicionarItem = True
            ElseIf ToolStripComboBox1.SelectedIndex = 2 AndAlso dado.Assunto = "Ideia" Then
                adicionarItem = True
            ElseIf ToolStripComboBox1.SelectedIndex = 3 AndAlso dado.Assunto = "Elogio" Then
                adicionarItem = True
            ElseIf ToolStripComboBox1.SelectedIndex = 0 Then
                adicionarItem = True
            End If

            If adicionarItem Then
                Dim mensagemTexto As String = If(dado.Mensagem, "")

                Dim resumoMensagem As String = fun.cortartexto(mensagemTexto, 30)

                ListBox1.Items.Add(resumoMensagem)


                listaexibida.Add(item.Key, dado)
            End If
        Next

        MessageBox.Show("Dados listados com sucesso!")
    End Sub

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        fun.AplicarBordasRedondas(30, Me)
        ToolStripComboBox1.SelectedIndex = 0
        Try
            fun.client = New FireSharp.FirebaseClient(fun.fcon)
        Catch ex As Exception
            MessageBox.Show("Erro de conexão: " & ex.Message)
        End Try
        Recarregar()
    End Sub

    Private Sub ListBox1_DoubleClick(sender As Object, e As EventArgs) Handles ListBox1.DoubleClick
        If ListBox1.SelectedIndex <> -1 Then
            Dim dadoSelecionado As DadoInfo = listaexibida.Values.ElementAt(ListBox1.SelectedIndex)
            Selecionado = dadoSelecionado
            Dim nj As New ver
            nj.ShowDialog()
        End If
    End Sub



    Private Sub Form1_Resize(sender As Object, e As EventArgs) Handles MyBase.Resize
        fun.AplicarBordasRedondas(30, Me)
    End Sub

    Private Sub XToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles XToolStripMenuItem.Click
        Application.Exit()
    End Sub

    Private Sub MenuStrip1_MouseDown(sender As Object, e As MouseEventArgs) Handles MenuStrip1.MouseDown
        If e.Button = MouseButtons.Left Then
            ReleaseCapture()
            SendMessage(Me.Handle, WM_NCLBUTTONDOWN, HT_CAPTION, 0)
        End If
    End Sub

    Private Sub XToolStripMenuItem_MouseEnter(sender As Object, e As EventArgs) Handles XToolStripMenuItem.MouseEnter
        XToolStripMenuItem.BackColor = Color.Red
    End Sub

    Private Sub XToolStripMenuItem_MouseLeave(sender As Object, e As EventArgs) Handles XToolStripMenuItem.MouseLeave
        XToolStripMenuItem.BackColor = SystemColors.ControlDark
    End Sub

    Private Sub ToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItem1.Click
        Me.WindowState = FormWindowState.Minimized
    End Sub

    Private Sub MinimiarToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles MinimiarToolStripMenuItem.Click
        Me.WindowState = FormWindowState.Minimized
    End Sub

    Private Sub FecharToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles FecharToolStripMenuItem.Click
        Application.Exit()
    End Sub

    Private Sub ComboBox2_SelectedIndexChanged(sender As Object, e As EventArgs)
        Recarregar()
    End Sub

    Private Sub ToolStripMenuItem2_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItem2.Click
        Recarregar()
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
