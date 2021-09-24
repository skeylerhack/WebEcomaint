Imports CrystalDecisions.CrystalReports.Engine

Public Class FrmPrint
    Private _dsSource As New DataSet
    Private _rptName As String = ""
    Private _type As Integer = -1
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal ds As DataSet, ByVal reportName As String, Optional ByVal type As Integer = -1)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _dsSource = ds
        _rptName = reportName
        _type = type
    End Sub
    Private Sub FrmPrint_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If _type <> -1 Then
            SplitContainer1.Panel1Collapsed = False
            SplitContainer2.Panel1Collapsed = True
        ElseIf _type <> 9 And _type <> 3 Then
            SplitContainer1.Panel1Collapsed = True
            SplitContainer2.Panel1Collapsed = True
        ElseIf _type = 9 Then
            SplitContainer1.Panel1Collapsed = True
            SplitContainer2.Panel1Collapsed = False
        ElseIf _type = 3 Then
            SplitContainer1.Panel1Collapsed = True
            SplitContainer2.Panel1Collapsed = True
        End If
        Print()
    End Sub
    Private Sub Print()
        Try
            Dim RptDocument As New ReportDocument()
            RptDocument.Load(Application.StartupPath & "/Reports/" & _rptName)
            RptDocument.SetDatabaseLogon(Commons.IConnections.Username, Commons.IConnections.Password, Commons.IConnections.Server, Commons.IConnections.Database)
            'RptDocument.DataSourceConnections.Clear()
            'RptDocument.DataSourceConnections.Item(0).SetConnection(Commons.IConnections.Server, Commons.IConnections.Database, Commons.IConnections.Username, Commons.IConnections.Password)

            RptDocument.SetDataSource(_dsSource)
            If _rptName = "Incident.rpt" Then
                SplitContainer1.Panel1Collapsed = True
                SplitContainer2.Panel1Collapsed = False
                RptDocument.Subreports(0).SetDataSource(_dsSource.Tables(1))

                RptDocument.PrintOptions.PaperOrientation = CrystalDecisions.Shared.PaperOrientation.Portrait
                RptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4
            End If
            If _rptName = "NearMiss.rpt" Then
                SplitContainer1.Panel1Collapsed = True
                SplitContainer2.Panel1Collapsed = True


                RptDocument.PrintOptions.PaperOrientation = CrystalDecisions.Shared.PaperOrientation.Portrait
                RptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4
            End If
            If _rptName = "SafetyAlert.rpt" Then
                SplitContainer1.Panel1Collapsed = True
                SplitContainer2.Panel1Collapsed = False
                RptDocument.Subreports(0).SetDataSource(_dsSource.Tables(1))

                RptDocument.PrintOptions.PaperOrientation = CrystalDecisions.Shared.PaperOrientation.Landscape
                RptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA4
            ElseIf _rptName = "StopCard_VI.rpt" Or _rptName = "StopCard_EN.rpt" Then
                SplitContainer1.Panel1Collapsed = False
                SplitContainer2.Panel1Collapsed = True
                RptDocument.PrintOptions.PaperOrientation = CrystalDecisions.Shared.PaperOrientation.Portrait
                RptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperA5
            End If

            CrystalReportViewer1.ReportSource = RptDocument
            CrystalReportViewer1.Visible = True
        Catch ex As Exception

        End Try
        
    End Sub
   

    Private Sub rdEN_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rdEN.CheckedChanged, rdVI.CheckedChanged
        If SplitContainer1.Panel1Collapsed = False Then
            If rdVI.Checked Then
                If _type = 1 Then 'StopCard
                    _rptName = "StopCard_VI.rpt"
                ElseIf _type = 2 Then 'Hazard
                    _rptName = "HazardVI.rpt"
                ElseIf _type = 3 Then 'Nearmiss
                    _rptName = "NearMiss.rpt"
                End If

            Else
                If _type = 1 Then
                    _rptName = "StopCard_EN.rpt"
                ElseIf _type = 2 Then 'Hazard
                    _rptName = "HazardEN.rpt"
                ElseIf _type = 3 Then 'Nearmiss
                    _rptName = "NearMiss.rpt"
                End If

            End If
        End If
        Print()
    End Sub

    Private Sub rdIncident_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rdIncident.CheckedChanged, rdSafety.CheckedChanged
        If SplitContainer2.Panel1Collapsed = False Then
            If rdIncident.Checked Then
                _rptName = "Incident.rpt"
            Else
                _rptName = "SafetyAlert.rpt"
            End If
        End If
        Print()
    End Sub
End Class