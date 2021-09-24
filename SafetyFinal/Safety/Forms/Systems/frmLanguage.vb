
Imports Commons.VS.Classes.Catalogue
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.Common
Imports System.Data.SqlClient.SqlConnection
Imports Microsoft.ApplicationBlocks.Data
Public Class frmLanguage
    Dim objDataTable As DataTable

    Private Sub frmLanguage_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Disposed

    End Sub
    Private Sub frmLanguage_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Commons.Modules.ObjSystems.DinhDang()
        If Commons.Modules.PermisString.Equals("Read only") Then
            BindData()
            Visiblebutton(True)

            EnableButton(False)
        Else
            EnableButton(True)

            BindData()
            Visiblebutton(True)
        End If
        AddHandler Me.VisibleChanged, AddressOf Me.frmLanguage_VisibleChanged
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
    End Sub

    Private Sub frmLanguage_VisibleChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'Handles Me.VisibleChanged
        If Me.Visible Then
            Commons.Modules.PermisString = Commons.Modules.ObjGroups.GetNHOM_FORM_QUYEN(Commons.Modules.UserName, Me.Name)
        End If
    End Sub

    Sub EnableButton(ByVal chon As Boolean)
        BtnSua.Enabled = chon
    End Sub
#Region "private"
    Private Sub RefeshLanguage()
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        Me.grdThongtinchitiet.Columns("VIETNAM").HeaderText = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "VIETNAM", Commons.Modules.TypeLanguage)
        Me.grdThongtinchitiet.Columns("ENGLISH").HeaderText = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "ENGLISH", Commons.Modules.TypeLanguage)
        Me.grdThongtinchitiet.Columns("CHINESE").HeaderText = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "CHINESE", Commons.Modules.TypeLanguage)
    End Sub

    Sub BindData()
        Try

            Dim bform As Byte
            If rdForm.Checked Then
                bform = 0
            Else
                bform = 1
            End If
            Dim dt As New DataTable
            'dt = New clsLANGUAGEControllers().GetLANGUAGEs(Commons.Modules.TypeLanguage, bform)


            Dim sSql As String

            sSql = "  SELECT DISTINCT FORM, ISNULL(HANG_MUC,' ')+(CASE '0' WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END)AS VIETNAM,HANG_MUC   FROM dbo.LANGUAGES   " & _
                     " WHERE     FORM = KEYWORD     AND FORM_HAY_REPORT= '0' " & _
                     " AND FORM IN('ChooseHazardReport','ChooseIncidentAndAccident','ChooseStopCard','FrmAUDIT','FrmConfirm','FrmPhanQuyenDuyet','FrmStopCard','FrmXNGuiMail','FrmHazardReport','FrmIncidentAndAccident','FrmInspection','FrmKhuVuc','FrmListCongViec','FrmListDepartment','FrmListDTTiepXuc','FrmListImg','FrmListMoiNguy','FrmListNhanVienSafety') " & _
                     " UNION ALL" & _
                     " SELECT DISTINCT FORM_NAME FORM,TEN_FORMS_VIET VIETNAM,NULL HANGMUC FROM CHI_TIET_FORMS WHERE LEFT(TEN_FORMS_VIET,3)='10.'" & _
                     " AND FORM_NAME NOT IN( SELECT DISTINCT FORM FROM dbo.LANGUAGES  " & _
                     " WHERE     FORM = KEYWORD     AND FORM_HAY_REPORT= '0' " & _
                     " AND FORM IN('ChooseHazardReport','ChooseIncidentAndAccident','ChooseStopCard','FrmAUDIT','FrmConfirm','FrmPhanQuyenDuyet','FrmStopCard','FrmXNGuiMail','FrmHazardReport','FrmIncidentAndAccident','FrmInspection','FrmKhuVuc','FrmListCongViec','FrmListDepartment','FrmListDTTiepXuc','FrmListImg','FrmListMoiNguy','FrmListNhanVienSafety') " & _
                     " )"
            dt.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql))

            Commons.Modules.ObjSystems.MLoadXtraGrid(grdForm, grvForm, dt, False, True, False, True)
            Commons.Modules.ObjSystems.MLoadNNXtraGrid(grvForm, Me.Name)
            grvForm.Columns("FORM").Group()
            grvForm.OptionsView.ShowGroupPanel = True
            grvForm.Columns("FORM").Visible = False
            '//Hide the GroupPanel
            grvForm.OptionsView.ShowGroupPanel = False

            '//Disable grouping
            grvForm.OptionsCustomization.AllowGroup = False

            '//Hide the header context menu
            'grvForm.OptionsMenu.EnableColumnMenu = False
            'grvForm.Columns(1).Width = 80
            'grvForm.Columns(2).Width = 20
            'grvForm.OptionsView.ColumnAutoWidth = False
            grvForm.ExpandAllGroups()
            'grvForm.BestFitColumns()
        Catch ex As Exception

        End Try

    End Sub

    Sub Showdata(ByVal FORM As String)
        objDataTable = New clsLANGUAGEControllers().GetLANGUAGE_FORMs(FORM)
        grdThongtinchitiet.DataSource = objDataTable
        grdThongtinchitiet.Columns(0).Visible = False
        grdThongtinchitiet.Columns("STT").Visible = False
        grdThongtinchitiet.Columns("MS_MODULE").Visible = False
        grdThongtinchitiet.Columns("KEYWORD").Visible = False
        grdThongtinchitiet.Columns("CHINESE").Visible = False
        Me.grdThongtinchitiet.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        Me.grdThongtinchitiet.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
    End Sub

    Sub Visiblebutton(ByVal chon As Boolean)
        BtnSua.Visible = chon
        BtnThoat.Visible = chon
        BtnGhi.Visible = Not chon
        BtnKhongghi.Visible = Not chon
        grdThongtinchitiet.ReadOnly = chon
        grdThongtinchitiet.Columns("KEYWORD").ReadOnly() = True
        grdForm.Enabled = chon
    End Sub
#End Region

    Private Sub lstDanhsachform_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'Try

        '    If lstDanhsachform.Items.Count <= 0 Then
        '        Exit Sub
        '    End If
        '    Showdata(lstDanhsachform.SelectedItem("FORM").ToString)
        'Catch ex As Exception
        '    Showdata("")
        'End Try

    End Sub


    Private Sub BtnSua_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnSua.Click
        Visiblebutton(False)
        rdReport.Enabled = False
        rdForm.Enabled = False
    End Sub

    Private Sub BtnKhongghi_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnKhongghi.Click
        Visiblebutton(True)
        Showdata(grvForm.GetFocusedRowCellValue("FORM").ToString)
        rdReport.Enabled = True
        rdForm.Enabled = True
    End Sub

    Private Sub BtnGhi_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnGhi.Click
        Dim objLanguageController As New clsLANGUAGEControllers()
        'objLanguageController.UpdateData(objDataTable, lstDanhsachform.SelectedItem("FORM").ToString)
        objLanguageController.UpdateData(objDataTable, grvForm.GetFocusedRowCellValue("FORM").ToString)

        Showdata(grvForm.GetFocusedRowCellValue("FORM").ToString)
        Visiblebutton(True)
        rdReport.Enabled = True
        rdForm.Enabled = True
    End Sub

    Private Sub BtnThoat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnThoat.Click
        Me.Close()
    End Sub

    Private Sub grdThongtinchitiet_RowValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellCancelEventArgs) Handles grdThongtinchitiet.RowValidating

    End Sub

    Private Sub rdForm_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdForm.CheckedChanged
        BindData()
    End Sub

    Private Sub txtTK_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtTK.TextChanged
        Dim dtTmp As New DataTable
        dtTmp = CType(grdForm.DataSource, DataTable)
        Try
            If txtTK.Text <> "" Then
                dtTmp.DefaultView.RowFilter = "VIETNAM like '%" & txtTK.Text & "%'"
            Else
                dtTmp.DefaultView.RowFilter = ""
            End If
            dtTmp = dtTmp.DefaultView.ToTable()
        Catch ex As Exception
            dtTmp.DefaultView.RowFilter = ""
            dtTmp = dtTmp.DefaultView.ToTable()
        End Try

    End Sub

    Private Sub lblTieude_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lblTieude.DoubleClick
        grdThongtinchitiet.Columns("KEYWORD").Visible = Not grdThongtinchitiet.Columns("KEYWORD").Visible
    End Sub


    Private Sub grvForm_FocusedRowChanged(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs) Handles grvForm.FocusedRowChanged
        Try

            If grvForm.RowCount <= 0 Then
                Exit Sub
            End If
            Showdata(grvForm.GetFocusedRowCellValue("FORM").ToString)
        Catch ex As Exception
            Showdata("")
        End Try
    End Sub

    Private Sub txtTim_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtTim.TextChanged
        Dim dtTmp As New DataTable
        dtTmp = CType(grdThongtinchitiet.DataSource, DataTable)
        Try
            If txtTim.Text <> "" Then
                dtTmp.DefaultView.RowFilter = "VIETNAM like '%" & txtTim.Text & "%'"
            Else
                dtTmp.DefaultView.RowFilter = ""
            End If
            dtTmp = dtTmp.DefaultView.ToTable()
        Catch ex As Exception
            dtTmp.DefaultView.RowFilter = ""
            dtTmp = dtTmp.DefaultView.ToTable()
        End Try
    End Sub

    Private Sub grvForm_EndGrouping(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles grvForm.EndGrouping
        'Try

        '    If grvForm.RowCount <= 0 Then
        '        Exit Sub
        '    End If
        '    Showdata(grvForm.GetFocusedRowCellValue("FORM").ToString)
        'Catch ex As Exception
        '    Showdata("")
        'End Try
    End Sub
End Class