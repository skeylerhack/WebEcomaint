<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmDanhMucQuanLyRuiRo
    Inherits DevExpress.XtraEditors.XtraForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.GridControl1 = New DevExpress.XtraGrid.GridControl
        Me.GridView1 = New DevExpress.XtraGrid.Views.Grid.GridView
        Me.ID = New DevExpress.XtraGrid.Columns.GridColumn
        Me.TaskID = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemMemoEdit2 = New DevExpress.XtraEditors.Repository.RepositoryItemMemoEdit
        Me.btTask = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemButtonEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit
        Me.LocationID = New DevExpress.XtraGrid.Columns.GridColumn
        Me.LocationDetail = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemTextEdit2 = New DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
        Me.HazardID = New DevExpress.XtraGrid.Columns.GridColumn
        Me.MUCRUIRO = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemComboBox1 = New DevExpress.XtraEditors.Repository.RepositoryItemComboBox
        Me.ContackObjectID = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemCheckedComboBoxEdit2 = New DevExpress.XtraEditors.Repository.RepositoryItemCheckedComboBoxEdit
        Me.btContactObject = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemButtonEdit2 = New DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit
        Me.HazardDetail = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemMemoEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemMemoEdit
        Me.IMG = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemPictureEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemPictureEdit
        Me.Picture = New DevExpress.XtraGrid.Columns.GridColumn
        Me.IncidentOrAcident = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemTextEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
        Me.PicPath = New DevExpress.XtraGrid.Columns.GridColumn
        Me.RepositoryItemTextEdit3 = New DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
        Me.RepositoryItemCheckedComboBoxEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemCheckedComboBoxEdit
        Me.TableLayoutPanel1 = New System.Windows.Forms.TableLayoutPanel
        Me.lbFilter = New System.Windows.Forms.Panel
        Me.Label1 = New System.Windows.Forms.Label
        Me.btnXFilter = New DevExpress.XtraEditors.SimpleButton
        Me.btnTKNG = New DevExpress.XtraEditors.SimpleButton
        Me.CheckedComboBoxEdit2 = New DevExpress.XtraEditors.CheckedComboBoxEdit
        Me.btnExportExcel = New DevExpress.XtraEditors.SimpleButton
        Me.btnAdd_Edit = New DevExpress.XtraEditors.SimpleButton
        Me.btnDelete = New DevExpress.XtraEditors.SimpleButton
        Me.btnSave = New DevExpress.XtraEditors.SimpleButton
        Me.btnCancel = New DevExpress.XtraEditors.SimpleButton
        Me.btnClose = New DevExpress.XtraEditors.SimpleButton
        Me.ContextMenuStrip1 = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.ShowImageToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem
        CType(Me.GridControl1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemMemoEdit2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemButtonEdit1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemTextEdit2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemComboBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemCheckedComboBoxEdit2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemButtonEdit2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemMemoEdit1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemPictureEdit1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemTextEdit1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemTextEdit3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemCheckedComboBoxEdit1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TableLayoutPanel1.SuspendLayout()
        Me.lbFilter.SuspendLayout()
        CType(Me.CheckedComboBoxEdit2.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ContextMenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'GridControl1
        '
        Me.GridControl1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.GridControl1.Location = New System.Drawing.Point(3, 3)
        Me.GridControl1.MainView = Me.GridView1
        Me.GridControl1.Name = "GridControl1"
        Me.GridControl1.RepositoryItems.AddRange(New DevExpress.XtraEditors.Repository.RepositoryItem() {Me.RepositoryItemPictureEdit1, Me.RepositoryItemTextEdit1, Me.RepositoryItemTextEdit2, Me.RepositoryItemTextEdit3, Me.RepositoryItemComboBox1, Me.RepositoryItemCheckedComboBoxEdit1, Me.RepositoryItemCheckedComboBoxEdit2, Me.RepositoryItemMemoEdit1, Me.RepositoryItemButtonEdit1, Me.RepositoryItemButtonEdit2, Me.RepositoryItemMemoEdit2})
        Me.GridControl1.Size = New System.Drawing.Size(911, 426)
        Me.GridControl1.TabIndex = 0
        Me.GridControl1.ViewCollection.AddRange(New DevExpress.XtraGrid.Views.Base.BaseView() {Me.GridView1})
        '
        'GridView1
        '
        Me.GridView1.Columns.AddRange(New DevExpress.XtraGrid.Columns.GridColumn() {Me.ID, Me.TaskID, Me.btTask, Me.LocationID, Me.LocationDetail, Me.HazardID, Me.MUCRUIRO, Me.ContackObjectID, Me.btContactObject, Me.HazardDetail, Me.IMG, Me.Picture, Me.IncidentOrAcident, Me.PicPath})
        Me.GridView1.FooterPanelHeight = 20
        Me.GridView1.GridControl = Me.GridControl1
        Me.GridView1.GroupFooterShowMode = DevExpress.XtraGrid.Views.Grid.GroupFooterShowMode.VisibleAlways
        Me.GridView1.IndicatorWidth = 35
        Me.GridView1.Name = "GridView1"
        Me.GridView1.OptionsCustomization.AllowRowSizing = True
        Me.GridView1.OptionsDetail.SmartDetailHeight = True
        Me.GridView1.OptionsNavigation.AutoFocusNewRow = True
        Me.GridView1.OptionsView.RowAutoHeight = True
        Me.GridView1.OptionsView.ShowFilterPanelMode = DevExpress.XtraGrid.Views.Base.ShowFilterPanelMode.Never
        Me.GridView1.OptionsView.ShowFooter = True
        Me.GridView1.OptionsView.ShowGroupPanel = False
        Me.GridView1.RowHeight = 60
        '
        'ID
        '
        Me.ID.Caption = "No."
        Me.ID.FieldName = "ID"
        Me.ID.Name = "ID"
        Me.ID.Width = 43
        '
        'TaskID
        '
        Me.TaskID.Caption = "Task"
        Me.TaskID.FieldName = "TaskID"
        Me.TaskID.Name = "TaskID"
        Me.TaskID.Visible = True
        Me.TaskID.VisibleIndex = 0
        Me.TaskID.Width = 51
        '
        'RepositoryItemMemoEdit2
        '
        Me.RepositoryItemMemoEdit2.Name = "RepositoryItemMemoEdit2"
        '
        'btTask
        '
        Me.btTask.Caption = " "
        Me.btTask.ColumnEdit = Me.RepositoryItemButtonEdit1
        Me.btTask.FieldName = "btTask"
        Me.btTask.Name = "btTask"
        Me.btTask.Visible = True
        Me.btTask.VisibleIndex = 1
        Me.btTask.Width = 30
        '
        'RepositoryItemButtonEdit1
        '
        Me.RepositoryItemButtonEdit1.AutoHeight = False
        Me.RepositoryItemButtonEdit1.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton})
        Me.RepositoryItemButtonEdit1.Name = "RepositoryItemButtonEdit1"
        Me.RepositoryItemButtonEdit1.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.HideTextEditor
        '
        'LocationID
        '
        Me.LocationID.Caption = "Location"
        Me.LocationID.FieldName = "LocationID"
        Me.LocationID.Name = "LocationID"
        Me.LocationID.Visible = True
        Me.LocationID.VisibleIndex = 2
        Me.LocationID.Width = 65
        '
        'LocationDetail
        '
        Me.LocationDetail.Caption = "Location Detail"
        Me.LocationDetail.ColumnEdit = Me.RepositoryItemTextEdit2
        Me.LocationDetail.FieldName = "LocationDetail"
        Me.LocationDetail.Name = "LocationDetail"
        Me.LocationDetail.Width = 103
        '
        'RepositoryItemTextEdit2
        '
        Me.RepositoryItemTextEdit2.AutoHeight = False
        Me.RepositoryItemTextEdit2.Name = "RepositoryItemTextEdit2"
        '
        'HazardID
        '
        Me.HazardID.Caption = "Hazard"
        Me.HazardID.FieldName = "HazardID"
        Me.HazardID.Name = "HazardID"
        Me.HazardID.Visible = True
        Me.HazardID.VisibleIndex = 3
        Me.HazardID.Width = 61
        '
        'MUCRUIRO
        '
        Me.MUCRUIRO.Caption = "Mức rủi ro"
        Me.MUCRUIRO.ColumnEdit = Me.RepositoryItemComboBox1
        Me.MUCRUIRO.FieldName = "MUCRUIRO"
        Me.MUCRUIRO.Name = "MUCRUIRO"
        Me.MUCRUIRO.SummaryItem.SummaryType = DevExpress.Data.SummaryItemType.Sum
        Me.MUCRUIRO.Visible = True
        Me.MUCRUIRO.VisibleIndex = 4
        Me.MUCRUIRO.Width = 77
        '
        'RepositoryItemComboBox1
        '
        Me.RepositoryItemComboBox1.AutoHeight = False
        Me.RepositoryItemComboBox1.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.RepositoryItemComboBox1.Items.AddRange(New Object() {"1", "2", "3", "4", "6", "8", "9", "12", "16"})
        Me.RepositoryItemComboBox1.Name = "RepositoryItemComboBox1"
        '
        'ContackObjectID
        '
        Me.ContackObjectID.Caption = "Contact Object"
        Me.ContackObjectID.ColumnEdit = Me.RepositoryItemCheckedComboBoxEdit2
        Me.ContackObjectID.FieldName = "ContackObjectID"
        Me.ContackObjectID.Name = "ContackObjectID"
        Me.ContackObjectID.Visible = True
        Me.ContackObjectID.VisibleIndex = 5
        Me.ContackObjectID.Width = 81
        '
        'RepositoryItemCheckedComboBoxEdit2
        '
        Me.RepositoryItemCheckedComboBoxEdit2.AutoHeight = False
        Me.RepositoryItemCheckedComboBoxEdit2.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.RepositoryItemCheckedComboBoxEdit2.Name = "RepositoryItemCheckedComboBoxEdit2"
        '
        'btContactObject
        '
        Me.btContactObject.Caption = " "
        Me.btContactObject.ColumnEdit = Me.RepositoryItemButtonEdit2
        Me.btContactObject.FieldName = "btContactObject"
        Me.btContactObject.Name = "btContactObject"
        Me.btContactObject.Visible = True
        Me.btContactObject.VisibleIndex = 6
        Me.btContactObject.Width = 30
        '
        'RepositoryItemButtonEdit2
        '
        Me.RepositoryItemButtonEdit2.AutoHeight = False
        Me.RepositoryItemButtonEdit2.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton})
        Me.RepositoryItemButtonEdit2.Name = "RepositoryItemButtonEdit2"
        Me.RepositoryItemButtonEdit2.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.HideTextEditor
        '
        'HazardDetail
        '
        Me.HazardDetail.Caption = "Hazard Detail"
        Me.HazardDetail.ColumnEdit = Me.RepositoryItemMemoEdit1
        Me.HazardDetail.FieldName = "HazardDetail"
        Me.HazardDetail.Name = "HazardDetail"
        Me.HazardDetail.Visible = True
        Me.HazardDetail.VisibleIndex = 7
        Me.HazardDetail.Width = 298
        '
        'RepositoryItemMemoEdit1
        '
        Me.RepositoryItemMemoEdit1.Name = "RepositoryItemMemoEdit1"
        '
        'IMG
        '
        Me.IMG.Caption = "Picture"
        Me.IMG.ColumnEdit = Me.RepositoryItemPictureEdit1
        Me.IMG.FieldName = "IMG"
        Me.IMG.Name = "IMG"
        Me.IMG.Visible = True
        Me.IMG.VisibleIndex = 8
        Me.IMG.Width = 69
        '
        'RepositoryItemPictureEdit1
        '
        Me.RepositoryItemPictureEdit1.Name = "RepositoryItemPictureEdit1"
        '
        'Picture
        '
        Me.Picture.Caption = "PicPath"
        Me.Picture.FieldName = "Picture"
        Me.Picture.Name = "Picture"
        '
        'IncidentOrAcident
        '
        Me.IncidentOrAcident.Caption = "Incident/ Accident"
        Me.IncidentOrAcident.ColumnEdit = Me.RepositoryItemTextEdit1
        Me.IncidentOrAcident.FieldName = "IncidentOrAcident"
        Me.IncidentOrAcident.Name = "IncidentOrAcident"
        Me.IncidentOrAcident.Visible = True
        Me.IncidentOrAcident.VisibleIndex = 9
        Me.IncidentOrAcident.Width = 133
        '
        'RepositoryItemTextEdit1
        '
        Me.RepositoryItemTextEdit1.AutoHeight = False
        Me.RepositoryItemTextEdit1.Name = "RepositoryItemTextEdit1"
        '
        'PicPath
        '
        Me.PicPath.FieldName = "PicPath"
        Me.PicPath.Name = "PicPath"
        '
        'RepositoryItemTextEdit3
        '
        Me.RepositoryItemTextEdit3.AutoHeight = False
        Me.RepositoryItemTextEdit3.Name = "RepositoryItemTextEdit3"
        '
        'RepositoryItemCheckedComboBoxEdit1
        '
        Me.RepositoryItemCheckedComboBoxEdit1.AutoHeight = False
        Me.RepositoryItemCheckedComboBoxEdit1.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.RepositoryItemCheckedComboBoxEdit1.Name = "RepositoryItemCheckedComboBoxEdit1"
        '
        'TableLayoutPanel1
        '
        Me.TableLayoutPanel1.ColumnCount = 1
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel1.Controls.Add(Me.lbFilter, 0, 1)
        Me.TableLayoutPanel1.Controls.Add(Me.GridControl1, 0, 0)
        Me.TableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel1.Location = New System.Drawing.Point(0, 0)
        Me.TableLayoutPanel1.Name = "TableLayoutPanel1"
        Me.TableLayoutPanel1.RowCount = 2
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40.0!))
        Me.TableLayoutPanel1.Size = New System.Drawing.Size(917, 472)
        Me.TableLayoutPanel1.TabIndex = 1
        '
        'lbFilter
        '
        Me.lbFilter.Controls.Add(Me.Label1)
        Me.lbFilter.Controls.Add(Me.btnXFilter)
        Me.lbFilter.Controls.Add(Me.btnTKNG)
        Me.lbFilter.Controls.Add(Me.CheckedComboBoxEdit2)
        Me.lbFilter.Controls.Add(Me.btnExportExcel)
        Me.lbFilter.Controls.Add(Me.btnAdd_Edit)
        Me.lbFilter.Controls.Add(Me.btnDelete)
        Me.lbFilter.Controls.Add(Me.btnSave)
        Me.lbFilter.Controls.Add(Me.btnCancel)
        Me.lbFilter.Controls.Add(Me.btnClose)
        Me.lbFilter.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lbFilter.Location = New System.Drawing.Point(3, 435)
        Me.lbFilter.Name = "lbFilter"
        Me.lbFilter.Size = New System.Drawing.Size(911, 34)
        Me.lbFilter.TabIndex = 2
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(127, 10)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(58, 13)
        Me.Label1.TabIndex = 103
        Me.Label1.Text = "Lọc dữ liệu"
        '
        'btnXFilter
        '
        Me.btnXFilter.Location = New System.Drawing.Point(399, 7)
        Me.btnXFilter.Name = "btnXFilter"
        Me.btnXFilter.Size = New System.Drawing.Size(22, 20)
        Me.btnXFilter.TabIndex = 102
        Me.btnXFilter.Text = "X"
        '
        'btnTKNG
        '
        Me.btnTKNG.Location = New System.Drawing.Point(422, 7)
        Me.btnTKNG.Name = "btnTKNG"
        Me.btnTKNG.Size = New System.Drawing.Size(22, 20)
        Me.btnTKNG.TabIndex = 101
        Me.btnTKNG.Text = "..."
        '
        'CheckedComboBoxEdit2
        '
        Me.CheckedComboBoxEdit2.Location = New System.Drawing.Point(189, 7)
        Me.CheckedComboBoxEdit2.Name = "CheckedComboBoxEdit2"
        Me.CheckedComboBoxEdit2.Properties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.CheckedComboBoxEdit2.Size = New System.Drawing.Size(209, 20)
        Me.CheckedComboBoxEdit2.TabIndex = 6
        '
        'btnExportExcel
        '
        Me.btnExportExcel.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnExportExcel.Appearance.Options.UseFont = True
        Me.btnExportExcel.Dock = System.Windows.Forms.DockStyle.Left
        Me.btnExportExcel.Location = New System.Drawing.Point(0, 0)
        Me.btnExportExcel.Name = "btnExportExcel"
        Me.btnExportExcel.Size = New System.Drawing.Size(106, 34)
        Me.btnExportExcel.TabIndex = 5
        Me.btnExportExcel.Text = "Xuất Excel"
        '
        'btnAdd_Edit
        '
        Me.btnAdd_Edit.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnAdd_Edit.Appearance.Options.UseFont = True
        Me.btnAdd_Edit.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnAdd_Edit.Location = New System.Drawing.Point(482, 0)
        Me.btnAdd_Edit.Name = "btnAdd_Edit"
        Me.btnAdd_Edit.Size = New System.Drawing.Size(100, 34)
        Me.btnAdd_Edit.TabIndex = 4
        Me.btnAdd_Edit.Text = "New/Edit"
        '
        'btnDelete
        '
        Me.btnDelete.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnDelete.Appearance.Options.UseFont = True
        Me.btnDelete.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnDelete.Location = New System.Drawing.Point(582, 0)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(75, 34)
        Me.btnDelete.TabIndex = 3
        Me.btnDelete.Text = "Delete"
        '
        'btnSave
        '
        Me.btnSave.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnSave.Appearance.Options.UseFont = True
        Me.btnSave.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnSave.Location = New System.Drawing.Point(657, 0)
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(75, 34)
        Me.btnSave.TabIndex = 2
        Me.btnSave.Text = "Save"
        Me.btnSave.Visible = False
        '
        'btnCancel
        '
        Me.btnCancel.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnCancel.Appearance.Options.UseFont = True
        Me.btnCancel.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnCancel.Location = New System.Drawing.Point(732, 0)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(104, 34)
        Me.btnCancel.TabIndex = 1
        Me.btnCancel.Text = "Cancel"
        Me.btnCancel.Visible = False
        '
        'btnClose
        '
        Me.btnClose.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnClose.Appearance.Options.UseFont = True
        Me.btnClose.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnClose.Location = New System.Drawing.Point(836, 0)
        Me.btnClose.Name = "btnClose"
        Me.btnClose.Size = New System.Drawing.Size(75, 34)
        Me.btnClose.TabIndex = 0
        Me.btnClose.Text = "Close"
        '
        'ContextMenuStrip1
        '
        Me.ContextMenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ShowImageToolStripMenuItem})
        Me.ContextMenuStrip1.Name = "ContextMenuStrip1"
        Me.ContextMenuStrip1.Size = New System.Drawing.Size(140, 26)
        '
        'ShowImageToolStripMenuItem
        '
        Me.ShowImageToolStripMenuItem.Image = Global.SafetyPlanModule.My.Resources.Resources._1462793327_fullscreen_alt
        Me.ShowImageToolStripMenuItem.Name = "ShowImageToolStripMenuItem"
        Me.ShowImageToolStripMenuItem.Size = New System.Drawing.Size(139, 22)
        Me.ShowImageToolStripMenuItem.Text = "Show Image"
        '
        'FrmDanhMucQuanLyRuiRo
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(917, 472)
        Me.Controls.Add(Me.TableLayoutPanel1)
        Me.LookAndFeel.SkinName = "Blue"
        Me.LookAndFeel.UseDefaultLookAndFeel = False
        Me.Name = "FrmDanhMucQuanLyRuiRo"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Quan lý rủi ro theo khu vuc"
        CType(Me.GridControl1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemMemoEdit2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemButtonEdit1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemTextEdit2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemComboBox1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemCheckedComboBoxEdit2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemButtonEdit2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemMemoEdit1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemPictureEdit1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemTextEdit1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemTextEdit3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemCheckedComboBoxEdit1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TableLayoutPanel1.ResumeLayout(False)
        Me.lbFilter.ResumeLayout(False)
        Me.lbFilter.PerformLayout()
        CType(Me.CheckedComboBoxEdit2.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ContextMenuStrip1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents GridControl1 As DevExpress.XtraGrid.GridControl
    Friend WithEvents GridView1 As DevExpress.XtraGrid.Views.Grid.GridView
    Friend WithEvents LocationID As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents HazardID As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents TaskID As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents ContackObjectID As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents IMG As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents IncidentOrAcident As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents ID As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents TableLayoutPanel1 As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents lbFilter As System.Windows.Forms.Panel
    Friend WithEvents btnAdd_Edit As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnDelete As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnSave As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnCancel As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnClose As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents RepositoryItemPictureEdit1 As DevExpress.XtraEditors.Repository.RepositoryItemPictureEdit
    Friend WithEvents RepositoryItemTextEdit1 As DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
    Friend WithEvents Picture As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents PicPath As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents LocationDetail As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents RepositoryItemTextEdit2 As DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
    Friend WithEvents HazardDetail As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents RepositoryItemTextEdit3 As DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
    Friend WithEvents ContextMenuStrip1 As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents ShowImageToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents MUCRUIRO As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents RepositoryItemComboBox1 As DevExpress.XtraEditors.Repository.RepositoryItemComboBox
    Friend WithEvents RepositoryItemCheckedComboBoxEdit2 As DevExpress.XtraEditors.Repository.RepositoryItemCheckedComboBoxEdit
    Friend WithEvents RepositoryItemCheckedComboBoxEdit1 As DevExpress.XtraEditors.Repository.RepositoryItemCheckedComboBoxEdit
    Friend WithEvents btnExportExcel As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents RepositoryItemMemoEdit1 As DevExpress.XtraEditors.Repository.RepositoryItemMemoEdit
    Friend WithEvents btTask As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents RepositoryItemButtonEdit1 As DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit
    Friend WithEvents btContactObject As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents RepositoryItemButtonEdit2 As DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit
    Friend WithEvents CheckedComboBoxEdit2 As DevExpress.XtraEditors.CheckedComboBoxEdit
    Friend WithEvents btnTKNG As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnXFilter As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents RepositoryItemMemoEdit2 As DevExpress.XtraEditors.Repository.RepositoryItemMemoEdit
End Class
