<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class FrmLeadershipType
    Inherits DevExpress.XtraEditors.XtraForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
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
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim ConditionValidationRule3 As DevExpress.XtraEditors.DXErrorProvider.ConditionValidationRule = New DevExpress.XtraEditors.DXErrorProvider.ConditionValidationRule()
        Dim ConditionValidationRule1 As DevExpress.XtraEditors.DXErrorProvider.ConditionValidationRule = New DevExpress.XtraEditors.DXErrorProvider.ConditionValidationRule()
        Me.RepositoryItemTextEdit3 = New DevExpress.XtraEditors.Repository.RepositoryItemTextEdit()
        Me.RepositoryItemTextEdit2 = New DevExpress.XtraEditors.Repository.RepositoryItemTextEdit()
        Me.RepositoryItemDateEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemDateEdit()
        Me.RepositoryItemTextEdit5 = New DevExpress.XtraEditors.Repository.RepositoryItemTextEdit()
        Me.RepositoryItemButtonEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit()
        Me.SplitContainer4 = New System.Windows.Forms.SplitContainer()
        Me.TableLayoutPanel1 = New System.Windows.Forms.TableLayoutPanel()
        Me.grdData = New DevExpress.XtraGrid.GridControl()
        Me.grvData = New DevExpress.XtraGrid.Views.Grid.GridView()
        Me.MA_SO = New DevExpress.XtraGrid.Columns.GridColumn()
        Me.NAME_VN = New DevExpress.XtraGrid.Columns.GridColumn()
        Me.NAME_EL = New DevExpress.XtraGrid.Columns.GridColumn()
        Me.NOTE = New DevExpress.XtraGrid.Columns.GridColumn()
        Me.ACTIVE = New DevExpress.XtraGrid.Columns.GridColumn()
        Me.ID_TYPE = New DevExpress.XtraGrid.Columns.GridColumn()
        Me.lblContent = New System.Windows.Forms.Label()
        Me.lblNameE = New System.Windows.Forms.Label()
        Me.txtNameE = New DevExpress.XtraEditors.TextEdit()
        Me.lblNameV = New System.Windows.Forms.Label()
        Me.lblMaSo = New System.Windows.Forms.Label()
        Me.txtNameV = New DevExpress.XtraEditors.TextEdit()
        Me.txtMaSo = New DevExpress.XtraEditors.TextEdit()
        Me.chkActive = New DevExpress.XtraEditors.CheckEdit()
        Me.txtNote = New DevExpress.XtraEditors.MemoEdit()
        Me.btnAdd_Edit = New DevExpress.XtraEditors.SimpleButton()
        Me.btnEdit = New DevExpress.XtraEditors.SimpleButton()
        Me.btnDelete = New DevExpress.XtraEditors.SimpleButton()
        Me.btnSave = New DevExpress.XtraEditors.SimpleButton()
        Me.btnCancel = New DevExpress.XtraEditors.SimpleButton()
        Me.btnExit = New DevExpress.XtraEditors.SimpleButton()
        Me.SplitContainer2 = New System.Windows.Forms.SplitContainer()
        Me.DxValidationProvider1 = New DevExpress.XtraEditors.DXErrorProvider.DXValidationProvider(Me.components)
        CType(Me.RepositoryItemTextEdit3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemTextEdit2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemDateEdit1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemDateEdit1.VistaTimeProperties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemTextEdit5, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemButtonEdit1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SplitContainer4.Panel1.SuspendLayout()
        Me.SplitContainer4.Panel2.SuspendLayout()
        Me.SplitContainer4.SuspendLayout()
        Me.TableLayoutPanel1.SuspendLayout()
        CType(Me.grdData, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grvData, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtNameE.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtNameV.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtMaSo.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.chkActive.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtNote.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SplitContainer2.Panel2.SuspendLayout()
        Me.SplitContainer2.SuspendLayout()
        CType(Me.DxValidationProvider1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'RepositoryItemTextEdit3
        '
        Me.RepositoryItemTextEdit3.AutoHeight = False
        Me.RepositoryItemTextEdit3.Name = "RepositoryItemTextEdit3"
        '
        'RepositoryItemTextEdit2
        '
        Me.RepositoryItemTextEdit2.AutoHeight = False
        Me.RepositoryItemTextEdit2.Name = "RepositoryItemTextEdit2"
        '
        'RepositoryItemDateEdit1
        '
        Me.RepositoryItemDateEdit1.AutoHeight = False
        Me.RepositoryItemDateEdit1.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.RepositoryItemDateEdit1.Name = "RepositoryItemDateEdit1"
        Me.RepositoryItemDateEdit1.VistaTimeProperties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton()})
        '
        'RepositoryItemTextEdit5
        '
        Me.RepositoryItemTextEdit5.AutoHeight = False
        Me.RepositoryItemTextEdit5.Name = "RepositoryItemTextEdit5"
        Me.RepositoryItemTextEdit5.ReadOnly = True
        '
        'RepositoryItemButtonEdit1
        '
        Me.RepositoryItemButtonEdit1.AutoHeight = False
        Me.RepositoryItemButtonEdit1.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton()})
        Me.RepositoryItemButtonEdit1.Name = "RepositoryItemButtonEdit1"
        Me.RepositoryItemButtonEdit1.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.HideTextEditor
        '
        'SplitContainer4
        '
        Me.SplitContainer4.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer4.FixedPanel = System.Windows.Forms.FixedPanel.Panel2
        Me.SplitContainer4.IsSplitterFixed = True
        Me.SplitContainer4.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer4.Name = "SplitContainer4"
        Me.SplitContainer4.Orientation = System.Windows.Forms.Orientation.Horizontal
        '
        'SplitContainer4.Panel1
        '
        Me.SplitContainer4.Panel1.Controls.Add(Me.TableLayoutPanel1)
        '
        'SplitContainer4.Panel2
        '
        Me.SplitContainer4.Panel2.Controls.Add(Me.btnAdd_Edit)
        Me.SplitContainer4.Panel2.Controls.Add(Me.btnEdit)
        Me.SplitContainer4.Panel2.Controls.Add(Me.btnDelete)
        Me.SplitContainer4.Panel2.Controls.Add(Me.btnSave)
        Me.SplitContainer4.Panel2.Controls.Add(Me.btnCancel)
        Me.SplitContainer4.Panel2.Controls.Add(Me.btnExit)
        Me.SplitContainer4.Size = New System.Drawing.Size(734, 345)
        Me.SplitContainer4.SplitterDistance = 319
        Me.SplitContainer4.SplitterWidth = 1
        Me.SplitContainer4.TabIndex = 0
        '
        'TableLayoutPanel1
        '
        Me.TableLayoutPanel1.ColumnCount = 3
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel1.Controls.Add(Me.grdData, 0, 5)
        Me.TableLayoutPanel1.Controls.Add(Me.lblContent, 0, 4)
        Me.TableLayoutPanel1.Controls.Add(Me.lblNameE, 0, 3)
        Me.TableLayoutPanel1.Controls.Add(Me.txtNameE, 1, 3)
        Me.TableLayoutPanel1.Controls.Add(Me.lblNameV, 0, 2)
        Me.TableLayoutPanel1.Controls.Add(Me.lblMaSo, 0, 1)
        Me.TableLayoutPanel1.Controls.Add(Me.txtNameV, 1, 2)
        Me.TableLayoutPanel1.Controls.Add(Me.txtMaSo, 1, 1)
        Me.TableLayoutPanel1.Controls.Add(Me.chkActive, 2, 1)
        Me.TableLayoutPanel1.Controls.Add(Me.txtNote, 1, 4)
        Me.TableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel1.Location = New System.Drawing.Point(0, 0)
        Me.TableLayoutPanel1.Name = "TableLayoutPanel1"
        Me.TableLayoutPanel1.RowCount = 6
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 8.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 50.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.Size = New System.Drawing.Size(734, 319)
        Me.TableLayoutPanel1.TabIndex = 33
        '
        'grdData
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.grdData, 3)
        Me.grdData.Dock = System.Windows.Forms.DockStyle.Fill
        Me.grdData.Location = New System.Drawing.Point(3, 139)
        Me.grdData.MainView = Me.grvData
        Me.grdData.Name = "grdData"
        Me.grdData.Size = New System.Drawing.Size(728, 177)
        Me.grdData.TabIndex = 32
        Me.grdData.ViewCollection.AddRange(New DevExpress.XtraGrid.Views.Base.BaseView() {Me.grvData})
        '
        'grvData
        '
        Me.grvData.Columns.AddRange(New DevExpress.XtraGrid.Columns.GridColumn() {Me.MA_SO, Me.NAME_VN, Me.NAME_EL, Me.NOTE, Me.ACTIVE, Me.ID_TYPE})
        Me.grvData.GridControl = Me.grdData
        Me.grvData.IndicatorWidth = 35
        Me.grvData.Name = "grvData"
        Me.grvData.OptionsBehavior.Editable = False
        Me.grvData.OptionsView.RowAutoHeight = True
        Me.grvData.OptionsView.ShowGroupPanel = False
        Me.grvData.ShowButtonMode = DevExpress.XtraGrid.Views.Base.ShowButtonModeEnum.[Default]
        '
        'MA_SO
        '
        Me.MA_SO.Caption = "MA_SO"
        Me.MA_SO.FieldName = "MA_SO"
        Me.MA_SO.Name = "MA_SO"
        Me.MA_SO.Visible = True
        Me.MA_SO.VisibleIndex = 0
        Me.MA_SO.Width = 137
        '
        'NAME_VN
        '
        Me.NAME_VN.Caption = "NAME_VN"
        Me.NAME_VN.FieldName = "NAME_VN"
        Me.NAME_VN.Name = "NAME_VN"
        Me.NAME_VN.Visible = True
        Me.NAME_VN.VisibleIndex = 1
        Me.NAME_VN.Width = 137
        '
        'NAME_EL
        '
        Me.NAME_EL.Caption = "NAME_EL"
        Me.NAME_EL.FieldName = "NAME_EL"
        Me.NAME_EL.Name = "NAME_EL"
        Me.NAME_EL.Visible = True
        Me.NAME_EL.VisibleIndex = 2
        Me.NAME_EL.Width = 137
        '
        'NOTE
        '
        Me.NOTE.Caption = "NOTE"
        Me.NOTE.FieldName = "NOTE"
        Me.NOTE.Name = "NOTE"
        Me.NOTE.Visible = True
        Me.NOTE.VisibleIndex = 3
        Me.NOTE.Width = 223
        '
        'ACTIVE
        '
        Me.ACTIVE.Caption = "ACTIVE"
        Me.ACTIVE.FieldName = "ACTIVE"
        Me.ACTIVE.Name = "ACTIVE"
        Me.ACTIVE.Visible = True
        Me.ACTIVE.VisibleIndex = 4
        Me.ACTIVE.Width = 55
        '
        'ID_TYPE
        '
        Me.ID_TYPE.Caption = "ID_TYPE"
        Me.ID_TYPE.FieldName = "ID_TYPE"
        Me.ID_TYPE.Name = "ID_TYPE"
        '
        'lblContent
        '
        Me.lblContent.AutoSize = True
        Me.lblContent.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lblContent.Location = New System.Drawing.Point(3, 86)
        Me.lblContent.Name = "lblContent"
        Me.lblContent.Size = New System.Drawing.Size(114, 50)
        Me.lblContent.TabIndex = 33
        Me.lblContent.Text = "Nội dung"
        Me.lblContent.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblNameE
        '
        Me.lblNameE.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lblNameE.Location = New System.Drawing.Point(3, 60)
        Me.lblNameE.Name = "lblNameE"
        Me.lblNameE.Size = New System.Drawing.Size(114, 26)
        Me.lblNameE.TabIndex = 35
        Me.lblNameE.Text = "lblNameE"
        Me.lblNameE.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'txtNameE
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.txtNameE, 2)
        Me.txtNameE.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtNameE.Location = New System.Drawing.Point(123, 63)
        Me.txtNameE.Name = "txtNameE"
        Me.txtNameE.Size = New System.Drawing.Size(608, 20)
        Me.txtNameE.TabIndex = 36
        '
        'lblNameV
        '
        Me.lblNameV.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lblNameV.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.lblNameV.Location = New System.Drawing.Point(3, 34)
        Me.lblNameV.Name = "lblNameV"
        Me.lblNameV.Size = New System.Drawing.Size(114, 26)
        Me.lblNameV.TabIndex = 35
        Me.lblNameV.Text = "lblNameV"
        Me.lblNameV.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblMaSo
        '
        Me.lblMaSo.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lblMaSo.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.lblMaSo.Location = New System.Drawing.Point(3, 8)
        Me.lblMaSo.Name = "lblMaSo"
        Me.lblMaSo.Size = New System.Drawing.Size(114, 26)
        Me.lblMaSo.TabIndex = 35
        Me.lblMaSo.Text = "lblMaSo"
        Me.lblMaSo.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'txtNameV
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.txtNameV, 2)
        Me.txtNameV.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtNameV.Location = New System.Drawing.Point(123, 37)
        Me.txtNameV.Name = "txtNameV"
        Me.txtNameV.Size = New System.Drawing.Size(608, 20)
        Me.txtNameV.TabIndex = 36
        ConditionValidationRule3.ConditionOperator = DevExpress.XtraEditors.DXErrorProvider.ConditionOperator.IsNotBlank
        ConditionValidationRule3.ErrorText = "This value is not valid"
        ConditionValidationRule3.ErrorType = DevExpress.XtraEditors.DXErrorProvider.ErrorType.Critical
        Me.DxValidationProvider1.SetValidationRule(Me.txtNameV, ConditionValidationRule3)
        '
        'txtMaSo
        '
        Me.txtMaSo.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtMaSo.Location = New System.Drawing.Point(123, 11)
        Me.txtMaSo.Name = "txtMaSo"
        Me.txtMaSo.Size = New System.Drawing.Size(508, 20)
        Me.txtMaSo.TabIndex = 36
        ConditionValidationRule1.ConditionOperator = DevExpress.XtraEditors.DXErrorProvider.ConditionOperator.IsNotBlank
        ConditionValidationRule1.ErrorText = "This value is not valid"
        ConditionValidationRule1.ErrorType = DevExpress.XtraEditors.DXErrorProvider.ErrorType.Critical
        Me.DxValidationProvider1.SetValidationRule(Me.txtMaSo, ConditionValidationRule1)
        '
        'chkActive
        '
        Me.chkActive.Location = New System.Drawing.Point(637, 11)
        Me.chkActive.Name = "chkActive"
        Me.chkActive.Properties.Caption = "chkActive"
        Me.chkActive.Properties.GlyphAlignment = DevExpress.Utils.HorzAlignment.Far
        Me.chkActive.Size = New System.Drawing.Size(94, 19)
        Me.chkActive.TabIndex = 37
        '
        'txtNote
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.txtNote, 2)
        Me.txtNote.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtNote.Location = New System.Drawing.Point(123, 89)
        Me.txtNote.Name = "txtNote"
        Me.txtNote.Size = New System.Drawing.Size(608, 44)
        Me.txtNote.TabIndex = 38
        '
        'btnAdd_Edit
        '
        Me.btnAdd_Edit.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnAdd_Edit.Appearance.Options.UseFont = True
        Me.btnAdd_Edit.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnAdd_Edit.Location = New System.Drawing.Point(230, 0)
        Me.btnAdd_Edit.Name = "btnAdd_Edit"
        Me.btnAdd_Edit.Size = New System.Drawing.Size(81, 25)
        Me.btnAdd_Edit.TabIndex = 45
        Me.btnAdd_Edit.Text = "New"
        '
        'btnEdit
        '
        Me.btnEdit.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnEdit.Appearance.Options.UseFont = True
        Me.btnEdit.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnEdit.Location = New System.Drawing.Point(311, 0)
        Me.btnEdit.Name = "btnEdit"
        Me.btnEdit.Size = New System.Drawing.Size(81, 25)
        Me.btnEdit.TabIndex = 44
        Me.btnEdit.Text = "Edit"
        '
        'btnDelete
        '
        Me.btnDelete.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnDelete.Appearance.Options.UseFont = True
        Me.btnDelete.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnDelete.Location = New System.Drawing.Point(392, 0)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(81, 25)
        Me.btnDelete.TabIndex = 43
        Me.btnDelete.Text = "Delete"
        '
        'btnSave
        '
        Me.btnSave.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnSave.Appearance.Options.UseFont = True
        Me.btnSave.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnSave.Location = New System.Drawing.Point(473, 0)
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(81, 25)
        Me.btnSave.TabIndex = 42
        Me.btnSave.Text = "Save"
        Me.btnSave.Visible = False
        '
        'btnCancel
        '
        Me.btnCancel.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnCancel.Appearance.Options.UseFont = True
        Me.btnCancel.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnCancel.Location = New System.Drawing.Point(554, 0)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(99, 25)
        Me.btnCancel.TabIndex = 41
        Me.btnCancel.Text = "Cancel"
        Me.btnCancel.Visible = False
        '
        'btnExit
        '
        Me.btnExit.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnExit.Appearance.Options.UseFont = True
        Me.btnExit.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnExit.Location = New System.Drawing.Point(653, 0)
        Me.btnExit.Name = "btnExit"
        Me.btnExit.Size = New System.Drawing.Size(81, 25)
        Me.btnExit.TabIndex = 39
        Me.btnExit.Text = "Close"
        '
        'SplitContainer2
        '
        Me.SplitContainer2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer2.FixedPanel = System.Windows.Forms.FixedPanel.Panel1
        Me.SplitContainer2.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer2.Name = "SplitContainer2"
        Me.SplitContainer2.Orientation = System.Windows.Forms.Orientation.Horizontal
        Me.SplitContainer2.Panel1Collapsed = True
        '
        'SplitContainer2.Panel2
        '
        Me.SplitContainer2.Panel2.Controls.Add(Me.SplitContainer4)
        Me.SplitContainer2.Size = New System.Drawing.Size(734, 345)
        Me.SplitContainer2.SplitterDistance = 62
        Me.SplitContainer2.SplitterWidth = 1
        Me.SplitContainer2.TabIndex = 1
        '
        'FrmLeadershipType
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(734, 345)
        Me.Controls.Add(Me.SplitContainer2)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.LookAndFeel.SkinName = "Blue"
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmLeadershipType"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "FrmLeadershipType"
        CType(Me.RepositoryItemTextEdit3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemTextEdit2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemDateEdit1.VistaTimeProperties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemDateEdit1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemTextEdit5, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemButtonEdit1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SplitContainer4.Panel1.ResumeLayout(False)
        Me.SplitContainer4.Panel2.ResumeLayout(False)
        Me.SplitContainer4.ResumeLayout(False)
        Me.TableLayoutPanel1.ResumeLayout(False)
        Me.TableLayoutPanel1.PerformLayout()
        CType(Me.grdData, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grvData, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtNameE.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtNameV.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtMaSo.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.chkActive.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtNote.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SplitContainer2.Panel2.ResumeLayout(False)
        Me.SplitContainer2.ResumeLayout(False)
        CType(Me.DxValidationProvider1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents SplitContainer4 As System.Windows.Forms.SplitContainer
    Friend WithEvents btnAdd_Edit As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnEdit As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnDelete As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnSave As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnCancel As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnExit As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents SplitContainer2 As System.Windows.Forms.SplitContainer
    Private WithEvents RepositoryItemTextEdit3 As DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
    Private WithEvents RepositoryItemTextEdit2 As DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
    Private WithEvents RepositoryItemDateEdit1 As DevExpress.XtraEditors.Repository.RepositoryItemDateEdit
    Private WithEvents RepositoryItemTextEdit5 As DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
    Private WithEvents RepositoryItemButtonEdit1 As DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit
    Friend WithEvents grdData As DevExpress.XtraGrid.GridControl
    Friend WithEvents grvData As DevExpress.XtraGrid.Views.Grid.GridView
    Friend WithEvents TableLayoutPanel1 As TableLayoutPanel
    Friend WithEvents lblNameE As Label
    Friend WithEvents txtNameE As DevExpress.XtraEditors.TextEdit
    Friend WithEvents lblContent As Label
    Friend WithEvents DxValidationProvider1 As DevExpress.XtraEditors.DXErrorProvider.DXValidationProvider
    Friend WithEvents MA_SO As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents NAME_VN As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents NAME_EL As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents NOTE As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents ACTIVE As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents lblNameV As Label
    Friend WithEvents lblMaSo As Label
    Friend WithEvents txtNameV As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtMaSo As DevExpress.XtraEditors.TextEdit
    Friend WithEvents ID_TYPE As DevExpress.XtraGrid.Columns.GridColumn
    Friend WithEvents chkActive As DevExpress.XtraEditors.CheckEdit
    Friend WithEvents txtNote As DevExpress.XtraEditors.MemoEdit
End Class
