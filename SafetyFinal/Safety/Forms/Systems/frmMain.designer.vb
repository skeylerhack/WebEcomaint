<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmMain
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
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmMain))
        Me.TimerLogin = New System.Windows.Forms.Timer(Me.components)
        Me.XtraTabbedMdiManager = New DevExpress.XtraTabbedMdi.XtraTabbedMdiManager(Me.components)
        Me.BarAndDockingController = New DevExpress.XtraBars.BarAndDockingController(Me.components)
        Me.DockManager = New DevExpress.XtraBars.Docking.DockManager(Me.components)
        Me.BarManager = New DevExpress.XtraBars.BarManager(Me.components)
        Me.Bar1 = New DevExpress.XtraBars.Bar()
        Me.BarMenu = New DevExpress.XtraBars.Bar()
        Me.Bar3 = New DevExpress.XtraBars.Bar()
        Me.BarUserName = New DevExpress.XtraBars.BarStaticItem()
        Me.BarCompanyInfo = New DevExpress.XtraBars.BarStaticItem()
        Me.BarVersion = New DevExpress.XtraBars.BarStaticItem()
        Me.BarDateUpdate = New DevExpress.XtraBars.BarStaticItem()
        Me.barDockControlTop = New DevExpress.XtraBars.BarDockControl()
        Me.barDockControlBottom = New DevExpress.XtraBars.BarDockControl()
        Me.barDockControlLeft = New DevExpress.XtraBars.BarDockControl()
        Me.barDockControlRight = New DevExpress.XtraBars.BarDockControl()
        Me.BarDateServer = New DevExpress.XtraBars.BarStaticItem()
        Me.RepositoryItemTextEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemTextEdit()
        Me.PictureEdit1 = New DevExpress.XtraEditors.PictureEdit()
        Me.txtQuickFind = New System.Windows.Forms.TextBox()
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        CType(Me.XtraTabbedMdiManager, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.BarAndDockingController, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DockManager, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.BarManager, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RepositoryItemTextEdit1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PictureEdit1.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'TimerLogin
        '
        Me.TimerLogin.Interval = 60000
        '
        'XtraTabbedMdiManager
        '
        Me.XtraTabbedMdiManager.AppearancePage.Header.Font = New System.Drawing.Font("Tahoma", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.XtraTabbedMdiManager.AppearancePage.Header.Options.UseFont = True
        Me.XtraTabbedMdiManager.AppearancePage.HeaderActive.Font = New System.Drawing.Font("Tahoma", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.XtraTabbedMdiManager.AppearancePage.HeaderActive.Options.UseFont = True
        Me.XtraTabbedMdiManager.AppearancePage.HeaderDisabled.Font = New System.Drawing.Font("Tahoma", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.XtraTabbedMdiManager.AppearancePage.HeaderDisabled.Options.UseFont = True
        Me.XtraTabbedMdiManager.Controller = Me.BarAndDockingController
        Me.XtraTabbedMdiManager.MdiParent = Me
        '
        'BarAndDockingController
        '
        Me.BarAndDockingController.AppearancesBar.Bar.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarAndDockingController.AppearancesBar.Bar.Options.UseFont = True
        Me.BarAndDockingController.AppearancesBar.Dock.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarAndDockingController.AppearancesBar.Dock.Options.UseFont = True
        Me.BarAndDockingController.AppearancesBar.MainMenu.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarAndDockingController.AppearancesBar.MainMenu.Options.UseFont = True
        Me.BarAndDockingController.AppearancesDocking.ActiveTab.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarAndDockingController.AppearancesDocking.ActiveTab.Options.UseFont = True
        Me.BarAndDockingController.AppearancesDocking.PanelCaption.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarAndDockingController.AppearancesDocking.PanelCaption.Options.UseFont = True
        Me.BarAndDockingController.AppearancesDocking.PanelCaptionActive.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarAndDockingController.AppearancesDocking.PanelCaptionActive.Options.UseFont = True
        Me.BarAndDockingController.AppearancesRibbon.FormCaption.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarAndDockingController.AppearancesRibbon.FormCaption.Options.UseFont = True
        Me.BarAndDockingController.LookAndFeel.SkinName = "Blue"
        Me.BarAndDockingController.LookAndFeel.UseDefaultLookAndFeel = False
        Me.BarAndDockingController.PropertiesBar.AllowLinkLighting = False
        '
        'DockManager
        '
        Me.DockManager.Controller = Me.BarAndDockingController
        Me.DockManager.Form = Me
        Me.DockManager.TopZIndexControls.AddRange(New String() {"DevExpress.XtraBars.BarDockControl", "DevExpress.XtraBars.StandaloneBarDockControl", "System.Windows.Forms.StatusBar", "DevExpress.XtraBars.Ribbon.RibbonStatusBar", "DevExpress.XtraBars.Ribbon.RibbonControl"})
        '
        'BarManager
        '
        Me.BarManager.AllowCustomization = False
        Me.BarManager.AllowMoveBarOnToolbar = False
        Me.BarManager.AllowQuickCustomization = False
        Me.BarManager.Bars.AddRange(New DevExpress.XtraBars.Bar() {Me.Bar1, Me.BarMenu, Me.Bar3})
        Me.BarManager.Controller = Me.BarAndDockingController
        Me.BarManager.DockControls.Add(Me.barDockControlTop)
        Me.BarManager.DockControls.Add(Me.barDockControlBottom)
        Me.BarManager.DockControls.Add(Me.barDockControlLeft)
        Me.BarManager.DockControls.Add(Me.barDockControlRight)
        Me.BarManager.DockManager = Me.DockManager
        Me.BarManager.Form = Me
        Me.BarManager.Items.AddRange(New DevExpress.XtraBars.BarItem() {Me.BarUserName, Me.BarCompanyInfo, Me.BarVersion, Me.BarDateUpdate, Me.BarDateServer})
        Me.BarManager.MainMenu = Me.BarMenu
        Me.BarManager.MaxItemId = 7
        Me.BarManager.RepositoryItems.AddRange(New DevExpress.XtraEditors.Repository.RepositoryItem() {Me.RepositoryItemTextEdit1})
        Me.BarManager.StatusBar = Me.Bar3
        '
        'Bar1
        '
        Me.Bar1.BarName = "Tools"
        Me.Bar1.DockCol = 0
        Me.Bar1.DockRow = 1
        Me.Bar1.DockStyle = DevExpress.XtraBars.BarDockStyle.Top
        Me.Bar1.OptionsBar.AllowQuickCustomization = False
        Me.Bar1.OptionsBar.DisableClose = True
        Me.Bar1.OptionsBar.DisableCustomization = True
        Me.Bar1.Text = "Tools"
        Me.Bar1.Visible = False
        '
        'BarMenu
        '
        Me.BarMenu.BarName = "Main menu"
        Me.BarMenu.DockCol = 0
        Me.BarMenu.DockRow = 0
        Me.BarMenu.DockStyle = DevExpress.XtraBars.BarDockStyle.Top
        Me.BarMenu.FloatLocation = New System.Drawing.Point(46, 179)
        Me.BarMenu.OptionsBar.AllowQuickCustomization = False
        Me.BarMenu.OptionsBar.DisableClose = True
        Me.BarMenu.OptionsBar.DisableCustomization = True
        Me.BarMenu.OptionsBar.MultiLine = True
        Me.BarMenu.OptionsBar.UseWholeRow = True
        Me.BarMenu.Text = "Main menu"
        '
        'Bar3
        '
        Me.Bar3.BarName = "Status bar"
        Me.Bar3.CanDockStyle = DevExpress.XtraBars.BarCanDockStyle.Bottom
        Me.Bar3.DockCol = 0
        Me.Bar3.DockRow = 0
        Me.Bar3.DockStyle = DevExpress.XtraBars.BarDockStyle.Bottom
        Me.Bar3.LinksPersistInfo.AddRange(New DevExpress.XtraBars.LinkPersistInfo() {New DevExpress.XtraBars.LinkPersistInfo(Me.BarUserName), New DevExpress.XtraBars.LinkPersistInfo(Me.BarCompanyInfo), New DevExpress.XtraBars.LinkPersistInfo(Me.BarVersion), New DevExpress.XtraBars.LinkPersistInfo(Me.BarDateUpdate)})
        Me.Bar3.OptionsBar.AllowQuickCustomization = False
        Me.Bar3.OptionsBar.DrawDragBorder = False
        Me.Bar3.Text = "Status bar"
        '
        'BarUserName
        '
        Me.BarUserName.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarUserName.Appearance.Options.UseFont = True
        Me.BarUserName.Caption = "  "
        Me.BarUserName.Id = 2
        Me.BarUserName.Name = "BarUserName"
        Me.BarUserName.TextAlignment = System.Drawing.StringAlignment.Near
        '
        'BarCompanyInfo
        '
        Me.BarCompanyInfo.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarCompanyInfo.Appearance.Options.UseFont = True
        Me.BarCompanyInfo.AutoSize = DevExpress.XtraBars.BarStaticItemSize.Spring
        Me.BarCompanyInfo.Caption = "  "
        Me.BarCompanyInfo.Id = 3
        Me.BarCompanyInfo.Name = "BarCompanyInfo"
        Me.BarCompanyInfo.TextAlignment = System.Drawing.StringAlignment.Center
        Me.BarCompanyInfo.Width = 32
        '
        'BarVersion
        '
        Me.BarVersion.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarVersion.Appearance.Options.UseFont = True
        Me.BarVersion.Caption = "  "
        Me.BarVersion.Id = 4
        Me.BarVersion.Name = "BarVersion"
        Me.BarVersion.TextAlignment = System.Drawing.StringAlignment.Near
        '
        'BarDateUpdate
        '
        Me.BarDateUpdate.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BarDateUpdate.Appearance.Options.UseFont = True
        Me.BarDateUpdate.Caption = "  "
        Me.BarDateUpdate.Id = 5
        Me.BarDateUpdate.Name = "BarDateUpdate"
        Me.BarDateUpdate.TextAlignment = System.Drawing.StringAlignment.Near
        '
        'BarDateServer
        '
        Me.BarDateServer.Id = 6
        Me.BarDateServer.Name = "BarDateServer"
        Me.BarDateServer.TextAlignment = System.Drawing.StringAlignment.Near
        '
        'RepositoryItemTextEdit1
        '
        Me.RepositoryItemTextEdit1.AutoHeight = False
        Me.RepositoryItemTextEdit1.Name = "RepositoryItemTextEdit1"
        '
        'PictureEdit1
        '
        Me.PictureEdit1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.PictureEdit1.EditValue = Global.My.Resources.Resources.Main
        Me.PictureEdit1.Location = New System.Drawing.Point(0, 50)
        Me.PictureEdit1.MenuManager = Me.BarManager
        Me.PictureEdit1.Name = "PictureEdit1"
        Me.PictureEdit1.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch
        Me.PictureEdit1.Size = New System.Drawing.Size(771, 496)
        Me.PictureEdit1.TabIndex = 5
        '
        'txtQuickFind
        '
        Me.txtQuickFind.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtQuickFind.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtQuickFind.ForeColor = System.Drawing.Color.Maroon
        Me.txtQuickFind.Location = New System.Drawing.Point(585, 1)
        Me.txtQuickFind.Name = "txtQuickFind"
        Me.txtQuickFind.Size = New System.Drawing.Size(177, 21)
        Me.txtQuickFind.TabIndex = 6
        Me.txtQuickFind.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        Me.txtQuickFind.Visible = False
        '
        'Timer1
        '
        Me.Timer1.Interval = 15000
        '
        'frmMain
        '
        Me.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Appearance.Options.UseFont = True
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(771, 570)
        Me.Controls.Add(Me.txtQuickFind)
        Me.Controls.Add(Me.PictureEdit1)
        Me.Controls.Add(Me.barDockControlLeft)
        Me.Controls.Add(Me.barDockControlRight)
        Me.Controls.Add(Me.barDockControlBottom)
        Me.Controls.Add(Me.barDockControlTop)
        Me.DoubleBuffered = True
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.IsMdiContainer = True
        Me.LookAndFeel.SkinName = "Blue"
        Me.LookAndFeel.UseDefaultLookAndFeel = False
        Me.Name = "frmMain"
        Me.Text = "SAFETY"
        Me.WindowState = System.Windows.Forms.FormWindowState.Maximized
        CType(Me.XtraTabbedMdiManager, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.BarAndDockingController, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DockManager, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.BarManager, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RepositoryItemTextEdit1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PictureEdit1.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents TimerLogin As System.Windows.Forms.Timer
    Friend WithEvents XtraTabbedMdiManager As DevExpress.XtraTabbedMdi.XtraTabbedMdiManager
    Friend WithEvents DockManager As DevExpress.XtraBars.Docking.DockManager
    Friend WithEvents BarAndDockingController As DevExpress.XtraBars.BarAndDockingController
    Friend WithEvents barDockControlLeft As DevExpress.XtraBars.BarDockControl
    Friend WithEvents barDockControlRight As DevExpress.XtraBars.BarDockControl
    Friend WithEvents barDockControlBottom As DevExpress.XtraBars.BarDockControl
    Friend WithEvents barDockControlTop As DevExpress.XtraBars.BarDockControl
    Friend WithEvents BarManager As DevExpress.XtraBars.BarManager
    Friend WithEvents Bar1 As DevExpress.XtraBars.Bar
    Friend WithEvents Bar3 As DevExpress.XtraBars.Bar
    Friend WithEvents RepositoryItemTextEdit1 As DevExpress.XtraEditors.Repository.RepositoryItemTextEdit
    Public WithEvents BarUserName As DevExpress.XtraBars.BarStaticItem
    Public WithEvents BarCompanyInfo As DevExpress.XtraBars.BarStaticItem
    Public WithEvents BarVersion As DevExpress.XtraBars.BarStaticItem
    Public WithEvents BarDateUpdate As DevExpress.XtraBars.BarStaticItem
    Public WithEvents BarMenu As DevExpress.XtraBars.Bar
    Friend WithEvents PictureEdit1 As DevExpress.XtraEditors.PictureEdit
    Friend WithEvents BarDateServer As DevExpress.XtraBars.BarStaticItem
    Friend WithEvents txtQuickFind As System.Windows.Forms.TextBox
    Friend WithEvents Timer1 As Timer
End Class
