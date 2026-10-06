Imports System.Drawing.Drawing2D
Imports FireSharp.Config
Imports FireSharp.Interfaces
Imports FireSharp.Response


Public Class Class1

End Class
Public Class funcoes
    Public fcon As New FirebaseConfig() With {
            .AuthSecret = "CRgO6zWmy52dTiOd4A5yoCHLw0nkHsQnNunRQX1k",
            .BasePath = "https://urbeco2026-default-rtdb.firebaseio.com/"
        }
    Public client As IFirebaseClient

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

    Public Async Function EditarMensagem(id As String, dado As DadoInfo) As Task
        Try
            Dim response As FirebaseResponse = Await client.UpdateAsync("Mensagens/" & id, dado)
            MessageBox.Show("Mensagem atualizada com sucesso!")
        Catch ex As Exception
            MessageBox.Show("Erro ao editar: " & ex.Message)
        End Try
    End Function

    Public Async Function DeletarMensagem(id As String) As Task
        Try
            Dim response As FirebaseResponse = Await client.DeleteAsync("Mensagens/" & id)
            MessageBox.Show("Mensagem deletada com sucesso!")
        Catch ex As Exception
            MessageBox.Show("Erro ao deletar: " & ex.Message)
        End Try
    End Function

    Public Function cortartexto(texto As String, tamanho As Integer) As String
        Dim resul As String = texto
        If texto.Length > 13 Then texto = $"{texto.Substring(0, 13)}..."

        Return texto
    End Function
End Class

Public Class DadoInfo
    Public Property Id As String
    Public Property Email As String
    Public Property Nome As String
    Public Property Finalizado As String = "false"
    Public Property Assunto As String
    Public Property Mensagem As String

End Class