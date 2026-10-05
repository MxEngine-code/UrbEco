Imports System.Drawing.Drawing2D

Public Class Class1

End Class
Public Class funcoes
    Public Sub AplicarBordasRedondas(raio As Integer, janela As Form)
        Dim caminho As New GraphicsPath()
        Dim retangulo As New Rectangle(0, 0, janela.Width, janela.Height)

        caminho.AddArc(retangulo.X, retangulo.Y, raio, raio, 180, 90)
        caminho.AddArc(retangulo.Width - raio, retangulo.Y, raio, raio, 270, 90)
        caminho.AddArc(retangulo.Width - raio, retangulo.Height - raio, raio, raio, 0, 90)
        caminho.AddArc(retangulo.X, retangulo.Height - raio, raio, raio, 90, 90)
        caminho.CloseFigure()

        janela.Region = New Region(caminho)
    End Sub

End Class

Public Class DadoInfo
    Public Property Id As String
    Public Property Email As String
    Public Property Finalizado As String = "false"
    Public Property Assunto As String
    Public Property Mensagem As String

End Class