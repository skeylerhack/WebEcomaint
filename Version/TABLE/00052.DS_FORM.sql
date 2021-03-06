IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DS_FORM]') AND type in (N'U'))
	DROP TABLE [dbo].[DS_FORM]


CREATE TABLE [dbo].[DS_FORM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DLL_NAME] [nvarchar](500) NOT NULL,
	[FORM_NAME] [nvarchar](500) NOT NULL,
	[LINK_BH] [nvarchar](500) NULL,
	[LINK_VIDEO] [nvarchar](1000)  NULL,
	[DESCRIPTION] [nvarchar](1000) NULL,
 CONSTRAINT [PK_DS_FORM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



SET IDENTITY_INSERT [dbo].[DS_FORM] ON 


INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (1, N'CMMS', N'Addon_ucMTest', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (2, N'CMMS', N'Bảng kê chi tiết vật tư nhập kho(Acecook)', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (3, N'CMMS', N'Bảng kê vật tư chi tiết (Acecook)', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (4, N'CMMS', N'Calibration plan outsite', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (5, N'CMMS', N'ChonPTDeXuat_CS', NULL, NULL, N'Chọn vật tư phụ tùng đề xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (6, N'CMMS', N'classfrmBoPhanChiPhiReport', NULL, NULL, N'BUTGET SUMMARY REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (7, N'CMMS', N'ctlDMTBDL', NULL, NULL, N'Danh mục các thiết bị đo lường an toàn cần hiệu chuẩn kiểm định')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (8, N'CMMS', N'ctrlNgungMay', NULL, NULL, N'Thời gian ngừng máy (Huda)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (9, N'CMMS', N'Đánh giá nhà cung cấp vật tư phụ tùng', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (10, N'CMMS', N'Dự toán vật tư tổng hợp (Acecook)', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (11, N'CMMS', N'FORM', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (12, N'CMMS', N'Form1', NULL, NULL, N'Form1')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (13, N'CMMS', N'FRM_KE_HOACH_BAO_TRI_TUAN', NULL, NULL, N'Kế hoạch bảo trì trong tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (14, N'CMMS', N'frmAccessory', NULL, NULL, N'Báo cáo vật tư sử dụng cho thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (15, N'CMMS', N'frmAllocateChooseVTPT', NULL, NULL, N'Phân bổ vật tư cho bộ phận chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (16, N'CMMS', N'frmAllocateVTPTForBPCP', NULL, NULL, N'Phân bổ vật tư cho bộ phận chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (17, N'CMMS', N'frmBacklog', NULL, NULL, N'Backlog')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (18, N'CMMS', N'frmBactho', NULL, NULL, N'Bậc thợ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (19, N'CMMS', N'frmBangtygia', NULL, NULL, N'Bảng tỷ giá')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (20, N'CMMS', N'frmBaoCaoBaoTri', NULL, NULL, N'Báo cáo bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (21, N'CMMS', N'frmBaoCaoKHBT_Kido', NULL, NULL, N'Kế hoạch bảo trì (Kido)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (22, N'CMMS', N'frmBaoCaoKho', NULL, NULL, N'Báo cáo tồn kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (23, N'CMMS', N'frmBaoTri', NULL, NULL, N'Hình thức/ Loại bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (24, N'CMMS', N'frmBCaoHCKD', NULL, NULL, N'Kế hoạch hiệu chuẩn kiểm dịnh')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (25, N'CMMS', N'frmBCNSKido', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (26, N'CMMS', N'frmBCTHThoiGianNgungMay', NULL, NULL, N'Thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (27, N'CMMS', N'frmBCTonKhoSum', NULL, NULL, N'Material and spare part inventory summary report')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (28, N'CMMS', N'frmBCTonKhoVTri', NULL, NULL, N'Báo cáo tồn kho theo vị trí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (29, N'CMMS', N'frmBCYeuCauNSD', NULL, NULL, N'THEO DÕI YÊU CẦU BẢO TRÌ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (30, N'CMMS', N'FrmBieuDoChiPhiBaoTri', NULL, NULL, N'Biểu đồ chi phí bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (31, N'CMMS', N'frmBieuDoMaintCost', NULL, NULL, N'Maint Cost Chart')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (32, N'CMMS', N'frmBieuDoMaintHour', NULL, NULL, N'Manhour chart')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (33, N'CMMS', N'frmBieudoMTBF_MTTR', NULL, NULL, N'MTBF AND MTTR CHART')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (34, N'CMMS', N'FrmBieuDoThoiGianNgungMay', NULL, NULL, N'Biểu đồ thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (35, N'CMMS', N'frmBieudoTopTGNM', NULL, NULL, N'HIGHTEST DOWNTIME')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (36, N'CMMS', N'FrmBoPhanChiPhiReport', NULL, NULL, N'BUDGET SUMMARY REPORTS')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (37, N'CMMS', N'frmBophanchiuphi', NULL, NULL, N'Bộ phận chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (38, N'CMMS', N'frmBophanchiuphi_cs', NULL, NULL, N'Bộ phận chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (39, N'CMMS', N'frmBoPhanChiuPhiRule', NULL, NULL, N'Distribution rule')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (40, N'CMMS', N'FrmBoPhanGSTT', NULL, NULL, N'Tên bộ phận giám sát tình trạng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (41, N'CMMS', N'frmBranch', NULL, NULL, N'Danh sách địa điểm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (42, N'CMMS', N'frmCachdathang', NULL, NULL, N'Cách đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (43, N'CMMS', N'frmCachNhapViTriPhuTung', NULL, NULL, N'Cách nhập vị trí phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (44, N'CMMS', N'FrmCanDoiKho', NULL, NULL, N'Điều chỉnh số lượng xuất kho cho phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (45, N'CMMS', N'frmCauseRemedy', NULL, NULL, N'Nguyên nhân và phương pháp khắc phục')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (46, N'CMMS', N'FrmChiPhiBaoTriTheoBPCP', NULL, NULL, N'Chi phí bảo trì theo bộ phận chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (47, N'CMMS', N'FrmChiPhiDichVuThueNai', NULL, NULL, N'Chi phí dịch vụ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (48, N'CMMS', N'frmChiPhiTheoThang', NULL, NULL, N'Chi phí theo tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (49, N'CMMS', N'frmChoiceCause', NULL, NULL, N'Chọn nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (50, N'CMMS', N'frmChoiceProblem', NULL, NULL, N'Chọn hư hỏng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (51, N'CMMS', N'frmChoiStreet', NULL, NULL, N'Chọn đường')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (52, N'CMMS', N'frmChonBaoTriDinhKyThang', NULL, NULL, N'Bảo trì định kỳ tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (53, N'CMMS', N'FrmChonBCPhieuCongViec', NULL, NULL, N'Phiếu công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (54, N'CMMS', N'FrmChonBieuDoKhaNangSanSangTheoLine', NULL, NULL, N'Chọn biểu đồ khả năng sẵn sàng.')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (55, N'CMMS', N'FrmChonBieuDoTGNMTheoNN', NULL, NULL, N'Chọn biểu đồ thời gian ngừng máy (h).')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (56, N'CMMS', N'FrmChonBieuDoTGNMTheoNN_PERCENT', NULL, NULL, N'Chọn biểu đồ thời gian ngừng máy (%).')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (57, N'CMMS', N'FrmChonBoPhanThayThe', NULL, NULL, N'Chọn bộ phận thay thế')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (58, N'CMMS', N'FrmChonCongViec', NULL, NULL, N'Chọn công việc cho bảo trì định kỳ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (59, N'CMMS', N'FrmChonCongViecBoPhan', NULL, NULL, N'Chọn công việc cho bộ phận')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (60, N'CMMS', N'frmChonCongViecChoBoPhan', NULL, NULL, N'Chọn công việc cho thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (61, N'CMMS', N'FrmChonCongViecChoBTPN', NULL, NULL, N'Chọn công việc cho bảo trì định kỳ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (62, N'CMMS', N'FrmChonCongViecChoEOR', NULL, NULL, N'Chọn công việc cho EOR')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (63, N'CMMS', N'FrmChonCongViecchoKHTT', NULL, NULL, N'Chọn công việc cho kế hoạch tổng thể')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (64, N'CMMS', N'frmChonCongViecChoPBT', NULL, NULL, N'Chọn công việc cho phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (65, N'CMMS', N'frmChonCongViecChoPBT_ThueNai', NULL, NULL, N'Chọn công việc cho phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (66, N'CMMS', N'frmChonConHanBaoHanh', NULL, NULL, N'Danh sách thiết bị còn hạn bảo hành')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (67, N'CMMS', N'frmChonCSWind', NULL, NULL, N'Bảo trì trong ngày')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (68, N'CMMS', N'frmChonDanhSachPhieuBaoTriTheoNgayCuoi', NULL, NULL, N'Danh sách Phiếu bảo trì theo ngày bảo trì cuối')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (69, N'CMMS', N'frmChonDeXuat', NULL, NULL, N'CHỌN ĐỀ XUẤT MUA HÀNG')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (70, N'CMMS', N'frmChonDichVuDatHang', NULL, NULL, N'Chọn dịch vụ cho đơn hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (71, N'CMMS', N'FrmChonDichVuThueNaiChoPBT', NULL, NULL, N'Chọn dịch vụ thuê nài cho phiếu trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (72, N'CMMS', N'frmChonDSTBAnToan', NULL, NULL, N'Danh sách thiết bị an toàn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (73, N'CMMS', N'frmChonGiamSatTinhTrang', NULL, NULL, N'Lịch bảo trì giám sát tình trạng thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (74, N'CMMS', N'frmChonGiamSatTinhTrang_BDL', NULL, NULL, N'Ke hoach giam sat tinh trang')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (75, N'CMMS', N'FrmChonHieuSuatSuDungLine', NULL, NULL, N'Biểu đồ hiệu suất sử dụng theo line ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (76, N'CMMS', N'frmChonHieuSuatSuDungMay', NULL, NULL, N'Hiệu suất sử dụng thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (77, N'CMMS', N'frmChonInDeXuat', NULL, NULL, N'Chọn in đề xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (78, N'CMMS', N'frmChonInPhieuBaoTri', NULL, NULL, N'Chọn in phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (79, N'CMMS', N'frmChonKeHoachPhanCongBT', NULL, NULL, N'Đề nghị và phân công bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (80, N'CMMS', N'frmChonKho', NULL, NULL, N'Chọn kho và vị trí mặc định')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (81, N'CMMS', N'frmChonKhoInDMTB', NULL, NULL, N'Tồn kho phụ tùng theo thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (82, N'CMMS', N'FrmChonKhoKiemKe', NULL, NULL, N'Kiểm kê kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (83, N'CMMS', N'frmChonLBT', NULL, NULL, N'Chọn loại bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (84, N'CMMS', N'FrmChonMachineDowntimeKPI', NULL, NULL, N'Chọn biểu đồ KPI.')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (85, N'CMMS', N'frmChonMAINTENANCT_REPORT_MONTHLY', NULL, NULL, N'Maintenance report monthly')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (86, N'CMMS', N'FrmChonMaterialsSewingDailyReport', NULL, NULL, N'Maintenance daily report')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (87, N'CMMS', N'frmChonMay', NULL, NULL, N'In barcode')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (88, N'CMMS', N'frmChonMay_TGNM', NULL, NULL, N'Copy thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (89, N'CMMS', N'FrmChonMayChoKHTT', NULL, NULL, N'Chọn thiết bị cho kế hoạch tổng thể')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (90, N'CMMS', N'frmChonNDD', NULL, NULL, N'Người đại diện')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (91, N'CMMS', N'frmChonNhanvienbaoduong', NULL, NULL, N'Chọn nhân viên cho công việc bảo dưỡng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (92, N'CMMS', N'frmChonNhanVienChoPBT', NULL, NULL, N'CHỌN NHÂN VIÊN CHO PHIẾU BẢO TRÌ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (93, N'CMMS', N'frmChonNX', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (94, N'CMMS', N'frmChonPhanTichHangTonKho', NULL, NULL, N'Chọn phân tích giá trị tồn kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (95, N'CMMS', N'frmChonPhuTung', NULL, NULL, N'Chọn phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (96, N'CMMS', N'frmChonPhuTung_DX', NULL, NULL, N'Chọn vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (97, N'CMMS', N'frmChonphutung_thaythe', NULL, NULL, N'Chọn vật tư, phụ tùng tương đương')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (98, N'CMMS', N'frmChonPhuTungcho_PBT', NULL, NULL, N'Chọn phụ tùng cho phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (99, N'CMMS', N'frmChonPhuTungThaySua', NULL, NULL, N'Chọn phụ tùng cho phiếu bảo trỉ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (100, N'CMMS', N'frmChonPSDV', NULL, NULL, N'Yêu cầu dịch vụ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (101, N'CMMS', N'frmChonPT', NULL, NULL, N'Chọn vật tư, phụ tùng cho phiếu nhập kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (102, N'CMMS', N'FrmChonPTchoBTPN', NULL, NULL, N'Chọn vật tư, phụ tùng cho BTĐK')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (103, N'CMMS', N'frmchonptchokhtt', NULL, NULL, N'Chọn vật tư, phụ tùng cho kế hoạch tổng thể')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (104, N'CMMS', N'frmChonPTDatHang', NULL, NULL, N'Chọn vật tư, phụ tùng cho đơn đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (105, N'CMMS', N'frmChonPTDeXuat', NULL, NULL, N'Chọn vật tư, phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (106, N'CMMS', N'frmChonPTDeXuat_CS', NULL, NULL, N'Chọn vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (107, N'CMMS', N'frmChonPTNhapKho', NULL, NULL, N'Chọn vật tư, phụ tùng cho phiếu nhập')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (108, N'CMMS', N'FrmChonTaiLieu', NULL, NULL, N'Chọn tài liệu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (109, N'CMMS', N'FrmChonTaiLieuChoEOR', NULL, NULL, N'Chọn tài liệu cho EOR')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (110, N'CMMS', N'frmChonTGCM', NULL, NULL, N'Nhập thời gian chạy máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (111, N'CMMS', N'frmChonTheKho', NULL, NULL, N'Thẻ kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (112, N'CMMS', N'frmChonThietBiBaoDuong', NULL, NULL, N'Chọn thiết bị cho công việc bảo dưỡng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (113, N'CMMS', N'FrmChonThoiGianNgungMay', NULL, NULL, N'Chọn dữ liệu in thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (114, N'CMMS', N'frmChonThongSo_NX', NULL, NULL, N'Thông số địa điểm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (115, N'CMMS', N'frmChonthongsoGSTT_BP', NULL, NULL, N'Chọn thông số giám sát tình trang- bộ phận')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (116, N'CMMS', N'frmChonThongSoGSTTDinhLuong', NULL, NULL, N'Chọn thông số định lượng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (117, N'CMMS', N'frmChonThongSoGSTTDinhTinh', NULL, NULL, N'Chọn thông số giám sát tình trạng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (118, N'CMMS', N'FrmChonTKTGNMTheoNN', NULL, NULL, N'Chọn dữ liệu tổng hợp thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (119, N'CMMS', N'frmChonTSGSTT', NULL, NULL, N'Chọn thông số giám sát tình trạng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (120, N'CMMS', N'frmChonvattubaoduong', NULL, NULL, N'Chọn vật tư cho công việc bảo dưỡng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (121, N'CMMS', N'FrmChonVatTuChoEOR', NULL, NULL, N'Chọn vật tư cho EOR')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (122, N'CMMS', N'frmchonvattutrongkho', NULL, NULL, N'Pick list')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (123, N'CMMS', N'FrmChonVatTuXuat', NULL, NULL, N'Chọn vật tư, phụ tùng xuất kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (124, N'CMMS', N'FrmChonVTCongViecHangNgay', NULL, NULL, N'Chọn vật tư cho Công việc hằng ngày')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (125, N'CMMS', N'frmChonVTINTPBT', NULL, NULL, N'Nhập trả VTPT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (126, N'CMMS', N'frmChonVTPTCS', NULL, NULL, N'Chọn VT PT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (127, N'CMMS', N'frmChonVTPTXuatKho', NULL, NULL, N'Chọn dữ liệu thống kê vật tư, phụ tùng xuất kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (128, N'CMMS', N'frmChonVTRequestPBT', NULL, NULL, N'Chọn VTPT yêu cầu cho PBT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (129, N'CMMS', N'frmChonYCSDPBT', NULL, NULL, N'Chọn yêu cầu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (130, N'CMMS', N'frmChooseAccessory', NULL, NULL, N'Báo cáo vật tư sử dụng cho thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (131, N'CMMS', N'frmChooseAccessory_Issued', NULL, NULL, N'Báo cáo vật tư sử dụng cho thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (132, N'CMMS', N'frmChuyenmon', NULL, NULL, N'Chuyên môn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (133, N'CMMS', N'frmClassProblem', NULL, NULL, N'Class hư hỏng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (134, N'CMMS', N'frmCompany', NULL, NULL, N'Thông tin chung')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (135, N'CMMS', N'frmCompareSLXuat', NULL, NULL, N'Đối chiếu với kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (136, N'CMMS', N'frmCONGNHAN_BPCP', NULL, NULL, N'Nhân viên - Bộ phận chụi phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (137, N'CMMS', N'frmCongViecHangNgay', NULL, NULL, N'Công việc hàng ngày')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (138, N'CMMS', N'frmCongViecHangNgayTBCTVT', NULL, NULL, N'Phân bố chi tiết vật tư cho thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (139, N'CMMS', N'FrmCongViecNhanVien', NULL, NULL, N'Danh sách công việc theo nhân viên')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (140, N'CMMS', N'frmContry', NULL, NULL, N'Danh mục quận huyện')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (141, N'CMMS', N'FrmCopyDecive', NULL, NULL, N'Copy cấu trúc thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (142, N'CMMS', N'frmCopyPhanQuyen', NULL, NULL, N'Chọn nhóm copy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (143, N'CMMS', N'FrmCP', NULL, NULL, N'Chọn dữ liệu in chi phí bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (144, N'CMMS', N'frmDanhmucchucvu', NULL, NULL, N'Danh mục chức vụ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (145, N'CMMS', N'frmDanhmuccongviec', N'http://vietsoft.com.vn/elearning/bai23.html', N'https://www.youtube.com/watch?v=umOfFB4_C5k', N'Danh mục công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (146, N'CMMS', N'frmDanhmucdonvi', NULL, NULL, N'Danh mục đơn vị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (147, N'CMMS', N'frmDanhmuchethong', NULL, NULL, N'Danh mục dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (148, N'CMMS', N'frmDanhmucngaynghi', NULL, NULL, N'Các ngày nghỉ lễ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (149, N'CMMS', N'frmDanhmucnhaxuong', NULL, NULL, N'Địa điểm hoạt động')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (150, N'CMMS', N'frmDanhmucphutung', NULL, NULL, N'Danh mục vật tư, phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (151, N'CMMS', N'frmDanhmucphutung_CS', N'http://vietsoft.com.vn/elearning/bai22.html', N'https://www.youtube.com/watch?v=BTE6g2Zq-vQ', N'Danh mục vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (152, N'CMMS', N'frmDanhmucto', NULL, NULL, N'Danh mục tổ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (153, N'CMMS', N'frmDanhSach', NULL, NULL, N'Danh mục các thiết bị đo lường an toàn cần hiệu chuẩn kiểm định')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (154, N'CMMS', N'frmDanhsachDDHtuDexuat', NULL, NULL, N'Danh sách đơn hàng của đề xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (155, N'CMMS', N'FrmDanhSachPhieuBaoTriTheoKhuVuc', NULL, NULL, N'Danh sách Phiếu bảo trì theo địa điểm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (156, N'CMMS', N'frmDanhSachPhieuBT', NULL, NULL, N'Danh sách phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (157, N'CMMS', N'FrmDanhSachPickList', NULL, NULL, N'Lấy dữ liệu từ Pick List')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (158, N'CMMS', N'frmDanhSachThietBiGiaTriKhiMua', NULL, NULL, N'Danh sách Thiết bị với giá trị khi mua ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (159, N'CMMS', N'FrmDanhSachVatTuBaoTri', NULL, NULL, N'Danh sách vật tư phụ tùng sử dụng để bảo trì thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (160, N'CMMS', N'frmDeXuatMuaHang', NULL, NULL, N'Đề xuất mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (161, N'CMMS', N'frmDeXuatMuaHang_CS', NULL, NULL, N'Ðề xuất mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (162, N'CMMS', N'frmDeXuatMuaHang_DUYTAN', NULL, NULL, N'Đề xuất đặt mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (163, N'CMMS', N'frmDeXuatMuaHang_New', NULL, NULL, N'Chọn vật tư, phụ tùng cho đề xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (164, N'CMMS', N'frmDeXuatMuaHang_VMPACK', NULL, NULL, N'Đề xuất mua hàng VMPACK')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (165, N'CMMS', N'FrmDiChuyenThietBi', NULL, NULL, N'Di chuyển thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (166, N'CMMS', N'FrmDiChuyenVatTu', NULL, NULL, N'Di chuyển vật tư, phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (167, N'CMMS', N'frmDistribution', NULL, NULL, N'Đơn vị chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (168, N'CMMS', N'frmDoiPass', NULL, NULL, N'Đổi mật khẩu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (169, N'CMMS', N'frmDonDatHang', NULL, NULL, N'Đơn đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (170, N'CMMS', N'frmDonDatHang_CS', NULL, NULL, N'Đơn đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (171, N'CMMS', N'frmDonDatHang_New', NULL, NULL, N'Đơn đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (172, N'CMMS', N'frmDonvido', NULL, NULL, N'Đơn vị đo')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (173, N'CMMS', N'frmDonvithoigian', NULL, NULL, N'Đơn vị thời gian')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (174, N'CMMS', N'frmDonvitinh', NULL, NULL, N'Đơn vị tính')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (175, N'CMMS', N'frmDonvitinhRuntime', NULL, NULL, N'Đơn vị TGCM')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (176, N'CMMS', N'frmDowntime', NULL, NULL, N'Thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (177, N'CMMS', N'frmDuongDanHinh', NULL, NULL, N'Đường dẫn hình')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (178, N'CMMS', N'frmDuyetSanXuat', NULL, NULL, N'Duyệt yêu cầu người sử dụng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (179, N'CMMS', N'frmEOR', NULL, NULL, N'Phiếu xin mua')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (180, N'CMMS', N'frmExportData', NULL, NULL, N'Tích hợp với kế toán')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (181, N'CMMS', N'frmExportExcel', NULL, NULL, N'Xuất dữ liệu ra Excel')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (182, N'CMMS', N'frmFactoryStatistical', NULL, NULL, N'Thống kê vật tư phụ tùng đến hạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (183, N'CMMS', N'frmFormsetting', NULL, NULL, N'Thiết lập chế độ hiển thị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (184, N'CMMS', N'frmGiaiPhap', NULL, NULL, N'Giải pháp')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (185, N'CMMS', N'frmGiamsattinhtrang', NULL, NULL, N'Tình trạng thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (186, N'CMMS', N'frmodreceive', NULL, NULL, N'Phiếu nhập xác')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (187, N'CMMS', N'frmodreturn', NULL, NULL, N'Phiếu xuất xác')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (188, N'CMMS', N'frmHangsanxuat', NULL, NULL, N'Hãng sản xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (189, N'CMMS', N'frmHieuchuan', NULL, NULL, N'Hiệu chuẩn và kiểm định')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (190, N'CMMS', N'frmImportExcel', NULL, NULL, N'Import dữ liệu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (191, N'CMMS', N'frmImportTonKho', NULL, NULL, N'Import tồn kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (192, N'CMMS', N'frmIncident_Detail', NULL, NULL, N'Bảng thống kê thông tin sự cố tủ chi tiết')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (193, N'CMMS', N'frmIncidents', NULL, NULL, N'Bảng thống kê thông tin sự cố - bảo trì tủ hàng tháng theo tỷ lệ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (194, N'CMMS', N'frmIncidents_Non_Recurring', NULL, NULL, N'Bảng thống kê sự cố theo nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (195, N'CMMS', N'frmInCongViecHangNgay', NULL, NULL, N'In công việc hằng ngày')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (196, N'CMMS', N'frmInDeXuatDFC', NULL, NULL, N'In đề xuất vật tư')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (197, N'CMMS', N'frmInKHTT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (198, N'CMMS', N'FrmInPhieuNhapKho', NULL, NULL, N'In danh sách phiếu nhập')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (199, N'CMMS', N'FrmInPhieuXuatKho', NULL, NULL, N'In danh sách phiếu xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (200, N'CMMS', N'frmInTGNMNN', NULL, NULL, N'Thời gian ngừng máy theo nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (201, N'CMMS', N'frmInTuKeHoachTongThe', NULL, NULL, N'In từ kế hoạch tổng thể')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (202, N'CMMS', N'frmJobCard', NULL, NULL, N'Phiếu công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (203, N'CMMS', N'frmKehoachbaotriduphong', NULL, NULL, N'Kế hoạch bảo trì định kỳ hàng năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (204, N'CMMS', N'frmKeHoachBTNam_TD', NULL, NULL, N'Kế hoạch bảo trì hàng năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (205, N'CMMS', N'frmKeHoachBTThang_TD', NULL, NULL, N'Kế hoạch bảo trì tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (206, N'CMMS', N'frmKehoachCongviec', NULL, NULL, N'Kế hoạch công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (207, N'CMMS', N'frmKeHoachSanXuat', NULL, NULL, N'Kế hoạch sản xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (208, N'CMMS', N'frmKehoachsuachuathietbi', NULL, NULL, N'Kế hoạch bảo trì (KKTL)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (209, N'CMMS', N'frmkehoachsx', NULL, NULL, N'Kế hoạch sản xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (210, N'CMMS', N'frmKehoachtongthe', NULL, NULL, N'Kế hoạch tổng thể')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (211, N'CMMS', N'frmKehoachtongthe_odd', NULL, NULL, N'Kế hoạch tổng thể')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (212, N'CMMS', N'frmKehoachtongtheNew', NULL, NULL, N'Kế hoạch bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (213, N'CMMS', N'frmKho', NULL, NULL, N'Danh mục kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (214, N'CMMS', N'frmKHTT_BTDKChoose', NULL, NULL, N'Bảo trì định kỳ!')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (215, N'CMMS', N'frmKHTT_ChuyenCVNamQuaThang', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (216, N'CMMS', N'frmKHTT_ChuyenCVThangQuaCVThang', NULL, NULL, N'Chuyển qua kế hoạch tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (217, N'CMMS', N'frmKHTT_ChuyenNamQuaNam', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (218, N'CMMS', N'frmKHTT_ChuyenThangQuaThang', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (219, N'CMMS', N'frmKHTT_CopyHangMucTo', NULL, NULL, N'Copy cho thiết bị khác')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (220, N'CMMS', N'frmKHTT_HangMucHistory', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (221, N'CMMS', N'frmKHTT_LayTuKHBTNam', NULL, NULL, N'Chuyển từ kế hoạch năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (222, N'CMMS', N'FrmKiemKeKho', NULL, NULL, N'Kiểm kê kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (223, N'CMMS', N'FrmKiemSoatDiChuyenBoPhan', NULL, NULL, N'Kiểm soát di chuyển bộ phận')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (224, N'CMMS', N'frmLanguage', NULL, NULL, N'Chỉnh sửa ngôn ngữ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (225, N'CMMS', N'frmLapphieubaotri_CS', NULL, NULL, N'LẬP PHIẾU BẢO TRÌ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (226, N'CMMS', N'FrmLichSuThietBi', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (227, N'CMMS', N'frmLichTau', NULL, NULL, N'Kế hoạch sản xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (228, N'CMMS', N'frmLịchTau', NULL, NULL, N'Kế hoạch sản xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (229, N'CMMS', N'frmLoaiBTQH', NULL, NULL, N'Quan hệ giữa các loại bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (230, N'CMMS', N'frmLoaichiphi', NULL, NULL, N'Loại chi phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (231, N'CMMS', N'frmLoaicongviec', NULL, NULL, N'Loại công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (232, N'CMMS', N'frmLoaiphutung', NULL, NULL, N'Nơi sử dụng VT PT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (233, N'CMMS', N'frmLoaivattu', NULL, NULL, N'Loại VT PT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (234, N'CMMS', N'frmLocDuLieu_DDH', NULL, NULL, N'Tìm đơn đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (235, N'CMMS', N'frmLocDuLieu_DX', NULL, NULL, N'Tìm đề xuất mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (236, N'CMMS', N'frmLocDuLieuNhapKho', NULL, NULL, N'Tìm phiếu nhập kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (237, N'CMMS', N'FrmLocthoigianngungmay', NULL, NULL, N'Lọc xem thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (238, N'CMMS', N'frmLogin', NULL, NULL, N'Đăng nhập')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (239, N'CMMS', N'FrmLyDo', NULL, NULL, N'Loại kế hoạch')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (240, N'CMMS', N'frmMachineUseAccessory', NULL, NULL, N'Bảng thống kê vật tư sử dụng hàng tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (241, N'CMMS', N'frmmain', N'http://vietsoft.com.vn/elearning/index.html', N'http://vietsoft.com.vn/elearning/gallery.html', N'Main form')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (242, N'CMMS', N'frmMaintaince_Colgate', NULL, NULL, N'Kế hoạch bảo trì tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (243, N'CMMS', N'frmMaintainceFor_Day_Of_Week', NULL, NULL, N'Kế hoạch bảo trì thiết bị trong tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (244, N'CMMS', N'frmMaintainceForMonth_Huda', NULL, NULL, N'Kế hoạch bảo trì trong tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (245, N'CMMS', N'frmMaintainceForWeek', NULL, NULL, N'Kế hoạch bảo trì thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (246, N'CMMS', N'frmMaintenance', NULL, NULL, N'Tình trạng bảo trì thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (247, N'CMMS', N'frmMaterialStatistical', NULL, NULL, N'Nhập vật tư phụ tùng sữa chữa')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (248, N'CMMS', N'frmMatKhau', NULL, NULL, N'Đổi mật khẩu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (249, N'CMMS', N'frmMayloaiBTPNchuky', NULL, NULL, N'Chu kỳ bảo trì định kỳ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (250, N'CMMS', N'frmMergeCongViec', NULL, NULL, N'Chuẩn hóa công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (251, N'CMMS', N'frmMonthlyConsumptionInputList', NULL, NULL, N'MAINTENANCE MATERIAL INPUT LIST')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (252, N'CMMS', N'frmMonthlyMaintanceMaterialReport', NULL, NULL, N'MAINTENANCE MATERIAL REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (253, N'CMMS', N'frmmonthlyMaterialOutputList', NULL, NULL, N'MAINTENANCE MATERIAL OUTPUT LIST')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (254, N'CMMS', N'frmMonthlyPOApproved', NULL, NULL, N'MAINTENANCE MATERIAL PO APPROVED')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (255, N'CMMS', N'frmMucUT', NULL, NULL, N'Mức ưu tiên')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (256, N'CMMS', N'frmNaite', NULL, NULL, N'Tiền tệ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (257, N'CMMS', N'frmNgungMay', NULL, NULL, N'Thời gian ngừng máy (Huda)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (258, N'CMMS', N'frmNguyennhandungmay', NULL, NULL, N'Nguyên nhân ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (259, N'CMMS', N'frmNguyenNhanHuHong', NULL, NULL, N'Nguyên nhân hư hỏng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (260, N'CMMS', N'frmNhacungcap', NULL, NULL, N'Danh sách nhà cung cấp')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (261, N'CMMS', N'frmNhacviec', NULL, NULL, N'Nhắc việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (262, N'CMMS', N'frmNhapThietBiMoi', NULL, NULL, N'Nhập thiết bị mới')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (263, N'CMMS', N'frmNhomquyen', NULL, NULL, N'Phân quyền người sử dụng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (264, N'CMMS', N'FrmNXHTBPCP', NULL, NULL, N'Địa điểm, dây chuyền sản xuất, bộ phận chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (265, N'CMMS', N'frmPassword', NULL, NULL, N'Mật khẩu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (266, N'CMMS', N'frmPBTBanHanh', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (267, N'CMMS', N'frmPCBT', NULL, NULL, N'Phân công bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (268, N'CMMS', N'frmPhanBoChiPhiAttachment', NULL, NULL, N'Phân bổ chi phí Attachment')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (269, N'CMMS', N'frmPhanCongBaoTri', NULL, NULL, N'Phân công bảo trì máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (270, N'CMMS', N'FrmPhanTichChiPhi', NULL, NULL, N'Phân tích cho phí bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (271, N'CMMS', N'FrmPhanTichChiPhi_DUYTAN', NULL, NULL, N'Phân tích cho phí bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (272, N'CMMS', N'frmPhanTichNNNMTheoNN', NULL, NULL, N'Phân tích hư hỏng theo đối tượng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (273, N'CMMS', N'frmPhatSinhDichVu', NULL, NULL, N'Yêu cầu dịch vụ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (274, N'CMMS', N'FrmPhieuBaoTri', NULL, NULL, N'Phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (275, N'CMMS', N'FrmPhieuBaoTri_New', NULL, NULL, N'Phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (276, N'CMMS', N'frmPhieuBaoTri_TuDong', NULL, NULL, N'Nghiệm thu phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (277, N'CMMS', N'frmPhieuBaoTriAllocateVTPT', NULL, NULL, N'Phân bổ vật tư cho phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (278, N'CMMS', N'frmPhieuBaoTriBHNT', NULL, NULL, N'Nghiệm thu phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (279, N'CMMS', N'frmPhieuNhapKho_New', NULL, NULL, N'Nhập kho vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (280, N'CMMS', N'FrmPhieuNhapKhoVatTu', NULL, NULL, N'Phiếu nhập kho vật tư, phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (281, N'CMMS', N'FrmPhieuNhapKhoVatTu_BDL', NULL, NULL, N'Phiếu nhập kho vật tư, phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (282, N'CMMS', N'FrmPhieuXuatKhoVatTu', NULL, NULL, N'Phiếu xuất kho vât tư, phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (283, N'CMMS', N'FrmPhieuXuatKhoVatTu_CS', NULL, NULL, N'Phiếu xuất kho vât tư, phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (284, N'CMMS', N'frmPhuTungMay', NULL, NULL, N'Phụ tùng trên cấu trúc thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (285, N'CMMS', N'frmPopUp', NULL, NULL, N'Chọn dữ liệu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (286, N'CMMS', N'frmPQuyen', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (287, N'CMMS', N'frmPrintShiftDuty', NULL, NULL, N'In ca trực')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (288, N'CMMS', N'frmProblemCause', NULL, NULL, N'Danh mục các hư hỏng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (289, N'CMMS', N'frmQuanlynhanvien', NULL, NULL, N'Quản lý nhân viên')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (290, N'CMMS', N'frmQuocGia', NULL, NULL, N'Quốc gia')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (291, N'CMMS', N'FrmRefreshData', NULL, NULL, N'Phục hồi dữ liệu kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (292, N'CMMS', N'frmReminder', NULL, NULL, N'Nhắc việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (293, N'CMMS', N'frmReminder_new', NULL, NULL, N'Nhắc việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (294, N'CMMS', N'frmReport', NULL, NULL, N'Report')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (295, N'CMMS', N'frmReportBaoTri_Huda', NULL, NULL, N'Phiếu bảo trì Huda (HUDA)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (296, N'CMMS', N'frmReportBaoTriNam_TD', NULL, NULL, N'Kế hoạch bảo trì năm (NMNTD)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (297, N'CMMS', N'frmReportDSHHBH', NULL, NULL, N'Danh sách thiết bị hết hạn bảo hành')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (298, N'CMMS', N'frmReportmailsetting', NULL, NULL, N'Thiết lập chế độ gửi email')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (299, N'CMMS', N'frmReports', NULL, NULL, N'Reports')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (300, N'CMMS', N'frmReportViewer_Approved', NULL, NULL, N'MAINTENANCE MATERIAL PO APPROVED')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (301, N'CMMS', N'frmReportViewer_Y', NULL, NULL, N'MAINTENANCE MATERIAL INPUT LIST')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (302, N'CMMS', N'frmReportViewer_Y_od_Receiver', NULL, NULL, N'MAINTENANCE VENDORS ODS RECEIPT REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (303, N'CMMS', N'frmReportViewer_Y_MATERIAL', NULL, NULL, N'MAINTENANCE MATERIAL REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (304, N'CMMS', N'frmReportViewer_Y_OUTPUT_LIST', NULL, NULL, N'MAINTENANCE MATERIAL OUTPUT LIST')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (305, N'CMMS', N'frmReportViewer_Y_PURCHASING_ORDER', NULL, NULL, N'MAINTENANCE VENDORS PO REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (306, N'CMMS', N'FrmROA', NULL, NULL, N'Phiếu duyệt mua')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (307, N'CMMS', N'frmrptBaoTriDinhKy', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (308, N'CMMS', N'frmrptBaoTriDinhKyThang', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (309, N'CMMS', N'frmrptBaoTriDinhKyThangCS', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (310, N'CMMS', N'frmrptBIEU_DO_CHI_PHI_BAO_TRI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (311, N'CMMS', N'frmrptBIEU_DO_CHI_PHI_MAINT_COST', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (312, N'CMMS', N'frmrptBIEU_DO_MAIN_HOUR', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (313, N'CMMS', N'frmrptBIEU_DO_THOI_GIAN_NGUNG_MAY', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (314, N'CMMS', N'frmrptBieuDohieuSuatLine', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (315, N'CMMS', N'frmrptBieuDoKhaNangSanSangLine', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (316, N'CMMS', N'frmrptBieuDoKPI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (317, N'CMMS', N'frmrptBieudoMTBF_MTTR', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (318, N'CMMS', N'frmrptBieuDoTGNMTheoNNHours', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (319, N'CMMS', N'frmrptBieuDoTGNMTheoNNPercent', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (320, N'CMMS', N'frmrptBieudoTopTGNM', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (321, N'CMMS', N'frmrptBoPhanChiPhiReport', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (322, N'CMMS', N'frmrptBreakdownTime', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (323, N'CMMS', N'frmrptCHI_PHI_BAO_TRI_THEO_BPCP', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (324, N'CMMS', N'frmrptCHI_PHI_BAO_TRI_THEO_LOAI_TB', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (325, N'CMMS', N'frmrptCHI_PHI_BAO_TRI_THEO_NHOM_TB', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (326, N'CMMS', N'frmrptCHI_PHI_CUA_PBT_THEO_LOAI_BAO_TRI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (327, N'CMMS', N'frmrptCHI_PHI_DICH_VU_THUE_NAI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (328, N'CMMS', N'frmrptCHI_PHI_THEO_DAY_CHUYEN', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (329, N'CMMS', N'frmrptChiPhiBaoTri', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (330, N'CMMS', N'frmrptChuKyHieuChuanNoi_Nai', NULL, NULL, N'Danh sách thiết bị có dụng cụ đo đã hiệu chuẩn, kiểm định trong năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (331, N'CMMS', N'frmrptCTY_DA_CUNG_CAP_VAT_TU', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (332, N'CMMS', N'frmrptDailyReport', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (333, N'CMMS', N'frmrptDANH_GIA_DICH_VU_KH', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (334, N'CMMS', N'frmrptDANH_GIA_NCC', NULL, NULL, N'Đánh giá nhà cung cấp vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (335, N'CMMS', N'frmrptDANH_SACH_BP_CP_THIET_BI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (336, N'CMMS', N'frmrptDANH_SACH_DC_THIET_BI_DUOC_LAP_DAT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (337, N'CMMS', N'frmrptDANH_SACH_NOI_LAP_DAT_THIET_BI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (338, N'CMMS', N'frmrptDANH_SACH_PHIEU_BAO_TRI_THEO_DIA_DIEM', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (339, N'CMMS', N'frmrptDANH_SACH_PHIEU_BAO_TRI_THEO_NGAY_CUOI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (340, N'CMMS', N'frmrptDANH_SACH_TAI_LIEU_THIET_BI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (341, N'CMMS', N'frmrptDANH_SACH_THIET_BI_GIA_KHI_MUA', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (342, N'CMMS', N'frmrptDANH_SACH_VAT_TU_DE_BAO_TRI_TB', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (343, N'CMMS', N'frmrptDanhsach_CV', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (344, N'CMMS', N'frmrptDanhsach_NCC', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (345, N'CMMS', N'frmrptDanhSach_ThietBi', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (346, N'CMMS', N'frmrptDanhsach_VTPT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (347, N'CMMS', N'frmrptDanhsach_VTPT_TheoMay', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (348, N'CMMS', N'frmrptDanhSachConHanBaoHanh', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (349, N'CMMS', N'frmrptDanhSachHetHanBaoHanh', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (350, N'CMMS', N'frmrptDanhSachNoiLapDatVaBPCPCuaThietBi', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (351, N'CMMS', N'frmrptDanhSachPhieuNhap', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (352, N'CMMS', N'frmrptDanhSachPhieuXuatKho', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (353, N'CMMS', N'frmrptDanhsachphutungdacbiet_KKTL', NULL, NULL, N'Danh mục thiết bị đặc biệt quan tâm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (354, N'CMMS', N'frmRptDanhsachphutungtheoDONVI_KKTL', NULL, NULL, N'Danh mục thiết bị theo đơn vị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (355, N'CMMS', N'frmRptDanhsachphutungtheoXuong_KKTL', NULL, NULL, N'Danh mục thiết bị theo phân xưởng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (356, N'CMMS', N'frmrptDanhsachTB_TheoDayChuyen', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (357, N'CMMS', N'frmrptDanhSachThietBiConKhauHao', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (358, N'CMMS', N'frmrptDanhSachThietBiDaHC', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (359, N'CMMS', N'frmrptDanhSachThietBiHetKhauHao', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (360, N'CMMS', N'frmrptDanhSachThietBiSuDungPhuTung', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (361, N'CMMS', N'frmrptDeXuatMuaHang', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (362, N'CMMS', N'frmrptDonDatHang', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (363, N'CMMS', N'frmrptDSBPChiuPhi', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (364, N'CMMS', N'frmrptDSCPBTTLoaiMay_LoaiTB', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (365, N'CMMS', N'frmrptDSCYCBTChuaNghiemThuTheoNV', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (366, N'CMMS', N'frmrptDSCYCBTDaNghiemThuTheoNV', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (367, N'CMMS', N'frmrptDSPBTChuaNghiemThuTLBT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (368, N'CMMS', N'frmrptDSPBTDaNghiemThuTLBT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (369, N'CMMS', N'frmrptDSTBAnToan', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (370, N'CMMS', N'frmrptDSTBTNLDHienTai', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (371, N'CMMS', N'frmrptGiaphutungtheodonhang', NULL, NULL, N'Giá phụ tùng theo đơn hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (372, N'CMMS', N'frmrptHIEU_SUAT_SU_DUNG_MAY', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (373, N'CMMS', N'frmrptHieuSuatSuDungMay', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (374, N'CMMS', N'frmrptKE_HOACH_BT_TUAN', NULL, NULL, N'Kế hoạch bảo trì tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (375, N'CMMS', N'frmrptKehoachbaotriduphong', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (376, N'CMMS', N'frmrptKeHoachBaoTriTrongTuan', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (377, N'CMMS', N'frmrptKeHoachGiamSatTinhTrang', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (378, N'CMMS', N'frmrptKeHoachGiamSatTinhTrang_BDL', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (379, N'CMMS', N'frmrptKeHoachPhanCongBT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (380, N'CMMS', N'frmrptKeHoachSuaChuaThietBi_KHTT_KKTL', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (381, N'CMMS', N'frmrptKeHoachSuaChuaThietBi_KKTL', NULL, NULL, N'Kế hoạch sửa chữa thiết bị(KKTL)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (382, N'CMMS', N'frmrptKHA_NANG_SAN_SANG_THEO_THIET_BI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (383, N'CMMS', N'frmrptKiemKeVT_PT', NULL, NULL, N'Kiểm kê kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (384, N'CMMS', N'frmrptKiemKeVT_PT_Load', NULL, NULL, N'Kiểm kê kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (385, N'CMMS', N'frmrptLICH_BAO_TRI_DINH_KI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (386, N'CMMS', N'frmrptLICH_HIEU_CHUAN_THIET_BI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (387, N'CMMS', N'frmrptLICH_SU_VAT_TU_SD_CHO_TB', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (388, N'CMMS', N'frmrptMAINTENANCT_REPORT_MONTHLY', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (389, N'CMMS', N'frmrptMaterialsSewingDailyReport', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (390, N'CMMS', N'frmrptMONTHLY_CONSUMPTION_INPUT_LIST', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (391, N'CMMS', N'frmrptMONTHLY_MAINTENANCE_MATERIAL_REPORT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (392, N'CMMS', N'frmrptMONTHLY_MATERIAL_OUTPUT_LIST', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (393, N'CMMS', N'frmrptMONTHLY_PO_APPROVED', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (394, N'CMMS', N'frmrptMTBF', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (395, N'CMMS', N'frmrptNhanVien', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (396, N'CMMS', N'frmrptPhanTichChiPhi', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (397, N'CMMS', N'frmrptPhanTichChiPhi_DUYTAN', NULL, NULL, N'Phân tích chi phí(Duy Tân)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (398, N'CMMS', N'frmrptPhanTichGiaTriTonKho', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (399, N'CMMS', N'frmrptPHIEU_CONG_VIEC', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (400, N'CMMS', N'frmrptPHU_TUNG_DUOC_CUNG_CAP_BOI_CTY', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (401, N'CMMS', N'frmrptQUI_DINH_VE_GSTT_THIET_BI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (402, N'CMMS', N'frmrptSparePartDailyBudgetCheckList', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (403, N'CMMS', N'frmrptTheKho', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (404, N'CMMS', N'frmrptTHOI_GIAN_NGUNG_MAY_CHART', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (405, N'CMMS', N'frmrptTHOI_GIAN_NGUNG_MAY_THEO_MAY', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (406, N'CMMS', N'frmrptTHOI_GIAN_NGUNG_MAY_THEO_NAM', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (407, N'CMMS', N'frmrptTHOI_GIAN_NGUNG_MAY_THEO_NGUYEN_NHAN', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (408, N'CMMS', N'frmrptThoigianchaymay', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (409, N'CMMS', N'frmrptThoiGianChayMayCuoiTuan', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (410, N'CMMS', N'frmrptthoigiansuachuatrungbinh', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (411, N'CMMS', N'frmrptthoigiansuachuatrungbinhgiua2lanhuhong', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (412, N'CMMS', N'frmrptTHONG_TIN_CHUNG_VA_THONG_SO_TB', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (413, N'CMMS', N'frmrptThongKeTanSuatNgungMay', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (414, N'CMMS', N'frmrptThongKeTanSuatNgungMay_NEW', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (415, N'CMMS', N'frmrptThongKeThoiGianNgungMay', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (416, N'CMMS', N'frmrptThongKeThoiGianNgungMayTheoNguyenNhan', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (417, N'CMMS', N'frmrptThongKeXuatVatTu', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (418, N'CMMS', N'frmrptTinhHinhSuaChuaThietBi_KKTL', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (419, N'CMMS', N'frmrptTON_KHO_KHONG_THEO_VI_TRI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (420, N'CMMS', N'frmrptTON_KHO_THEO_PHIEU_NHAP', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (421, N'CMMS', N'frmrptTON_KHO_THEO_VI_TRI', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (422, N'CMMS', N'frmrptTON_KHO_THEO_VI_TRI_BAYER', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (423, N'CMMS', N'frmrptTonKhoTheoDayChuyen', NULL, NULL, N'Tồn kho phụ tùng theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (424, N'CMMS', N'frmrptVAT_TU_XUAT_KHO', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (425, N'CMMS', N'frmrptVENDOR_REPORT_OD_RECEIPT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (426, N'CMMS', N'frmrptVENDOR_REPORT_PURCHASING_ORDER', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (427, N'CMMS', N'frmrptWEP_REPORT', NULL, NULL, N'frmrptWEP_REPORT (không sử dụng)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (428, N'CMMS', N'frmSchedules', NULL, NULL, N'Thiết lập chế độ gửi email')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (429, N'CMMS', N'frmSearchPT', NULL, NULL, N'Tìm vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (430, N'CMMS', N'FrmSparePartDaylyBudget', NULL, NULL, N'Spare part daily budget check list')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (431, N'CMMS', N'frmStock', NULL, NULL, N'Cập nhật Min-Max')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (432, N'CMMS', N'frmStreet', NULL, NULL, N'Danh mục đường')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (433, N'CMMS', N'frmTaiLieu', NULL, NULL, N'Quy trình duyệt tài liệu.')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (434, N'CMMS', N'frmTaoKHTT', NULL, NULL, N'Tạo hạng mục kế hoạch')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (435, N'CMMS', N'frmTest', NULL, NULL, N'frmTest')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (436, N'CMMS', N'FrmTGDMAY', NULL, NULL, N'Thời gian trung bình giữa hai lần hư hỏng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (437, N'CMMS', N'frmTGSC_TheoMay', NULL, NULL, N'@frmTGSC_TheoMay@')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (438, N'CMMS', N'frmThietBi', NULL, NULL, N'Loại / Nhóm thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (439, N'CMMS', N'frmThoigianchayma', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (440, N'CMMS', N'frmThoigianchaymay', NULL, NULL, N'Thời gian chạy máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (441, N'CMMS', N'FrmThoiGianNgungMayNew', NULL, NULL, N'Thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (442, N'CMMS', N'FrmThoiGianNgungMaytheoNguyenNhan', NULL, NULL, N'ThờI gian ngừng máy theo nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (443, N'CMMS', N'frmThoiGianTrongCuaThietBi', NULL, NULL, N'Thời gian trống của thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (444, N'CMMS', N'frmThongKeNhapTheoKH', NULL, NULL, N'Thống kê nhập kho theo nhà cung cấp')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (445, N'CMMS', N'frmThongKeVatTu', NULL, NULL, N'Thống kê vật tư phụ tùng thay thế')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (446, N'CMMS', N'frmThongKeVT', NULL, NULL, N'Thống kê xuất vật tư')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (447, N'CMMS', N'frmThongsoGSTT', NULL, NULL, N'Thông số giám sát tình trạng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (448, N'CMMS', N'frmThongsothietbi', NULL, NULL, N'Thông số thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (449, N'CMMS', N'frmThongTinDonViSuDung', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (450, N'CMMS', N'frmThongtinnhacungcap', NULL, NULL, N'Nhà cung cấp')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (451, N'CMMS', N'frmThongtinthietbi', NULL, NULL, N'Thông tin thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (452, N'CMMS', N'frmTimMay', NULL, NULL, N'Tìm thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (453, N'CMMS', N'frmTimMayTTTB', NULL, NULL, N'Tìm thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (454, N'CMMS', N'frmTimNCTy', NULL, NULL, N'')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (455, N'CMMS', N'frmTimNhanVien', NULL, NULL, N'Tìm nhân viên')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (456, N'CMMS', N'frmTimPBT', NULL, NULL, N'Tìm phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (457, N'CMMS', N'FrmTimThongTinPT', NULL, NULL, N'Tỉm thông tin phụ tùng trong kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (458, N'CMMS', N'frmTimVT', NULL, NULL, N'Tìm vật tư phụ tùng đề xuất')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (459, N'CMMS', N'frmTimVTPT', NULL, NULL, N'Tìm vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (460, N'CMMS', N'frmTinhHinhSuaChuaThietBi_KKTL', NULL, NULL, N'Tình hình sửa chữa thiết bị (KKTL)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (461, N'CMMS', N'frmTinhHinhTonKho', NULL, NULL, N'Tình hình tồn kho phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (462, N'CMMS', N'frmTinhHinhTonKhoThayThe', NULL, NULL, N'Tồn kho của các vật tư phụ tùng tương đương')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (463, N'CMMS', N'frmTinhTrangBoPhan', NULL, NULL, N'Tình trạng bộ phận')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (464, N'CMMS', N'frmTKVTChuaXuat', NULL, NULL, N'Báo cáo vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (465, N'CMMS', N'frmTonkhotheoline', NULL, NULL, N'Chọn dữ liệu tồn kho theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (466, N'CMMS', N'frmTonKhoTheoPBT', NULL, NULL, N'Tồn kho theo phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (467, N'CMMS', N'frmTrinhdo', NULL, NULL, N'Trình độ văn hoá')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (468, N'CMMS', N'frmTrucca', NULL, NULL, N'Trực ca')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (469, N'CMMS', N'FrmTSDMAY', NULL, NULL, N'Chọn dữ liệu in tần suất ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (470, N'CMMS', N'FrmTSDMAY_NEW', NULL, NULL, N'Chọn dữ liệu in tần suất ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (471, N'CMMS', N'frmTTSP', NULL, NULL, N'Thông tin sản phẩm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (472, N'CMMS', N'frmUserLogin', NULL, NULL, N'User login')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (473, N'CMMS', N'frmVatTuPhuTung', NULL, NULL, N'Tìm vật tư nhập kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (474, N'CMMS', N'frmVendorReportodReceipt', NULL, NULL, N'MAINTENANCE VENDORS ODS RECEIPT REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (475, N'CMMS', N'frmVendorReportPurchasinrder', NULL, NULL, N'MAINTENANCE VENDORS PO REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (476, N'CMMS', N'frmXuatNhapTon_TD', NULL, NULL, N'Báo cáo tồn kho cho NTD')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (477, N'CMMS', N'frmYCSDChonMay', NULL, NULL, N'Chọn thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (478, N'CMMS', N'frmYeuCauBT', NULL, NULL, N'Xem xét các yêu cầu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (479, N'CMMS', N'frmYeucaucuaNSD', NULL, NULL, N'Yêu cầu của người sử dụng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (480, N'CMMS', N'frmYeucaucuaNSD_Duyet', NULL, NULL, N'Duyệt yêu cầu ngừoi sử dụng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (481, N'CMMS', N'FrnThongtinthietbi', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (482, N'CMMS', N'functionHamToanCuc', NULL, NULL, N'Hàm toàn cục')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (483, N'CMMS', N'GetDSPNTreHoaDon', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (484, N'CMMS', N'getrptLICH_SU_VAT_TU_SD_CHO_TB', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (485, N'CMMS', N'GetrptMONTHLY_MATERIAL_OUTPUT_LIST', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (486, N'CMMS', N'ImportDataFromExcel', NULL, NULL, N'Import excel CV-TSGSTT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (487, N'CMMS', N'ImportExcel', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (488, N'CMMS', N'K? ho?ch hi?u chu?n ki?m d?nh', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (489, N'CMMS', N'lblLVT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (490, N'CMMS', N'ListStockReport', NULL, NULL, N'Báo cáo nhập, xuất, tồn kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (491, N'CMMS', N'ListWarranty', NULL, NULL, N'Báo cáo KPI công tác bảo hành')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (492, N'CMMS', N'msgNhapTraKhongThanhCong', NULL, NULL, N'Nhập trả không thành công!')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (493, N'CMMS', N'ReportCustomerInfo', NULL, NULL, N'Bảng thống kê thông tin khách hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (494, N'CMMS', N'ReportMaintaince', NULL, NULL, N'Bảng thống kê thông tin bảo trì chi tiết')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (495, N'CMMS', N'ReportManager.frmReports, Text: Reports', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (496, N'CMMS', N'ReportManager.frmReports, Text: Thiết lập chế độ hiển thị', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (497, N'CMMS', N'reportTitleCustomer', NULL, NULL, N'BẢNG THỐNG KÊ THÔNG TIN KHÁCH HÀNG')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (498, N'CMMS', N'rpt_LICH_SU_PT', NULL, NULL, N'Lịch sử thay thế phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (499, N'CMMS', N'rpt_Test', NULL, NULL, N'rpt_Test')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (500, N'CMMS', N'rpt_Title_THOI_GIAN_CHAY_MAY', NULL, NULL, N'Thời gian chạy máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (501, N'CMMS', N'rpt_Title_THOI_GIAN_CHAY_MAY_THEO_DC', NULL, NULL, N'Thời gian chạy máy theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (502, N'CMMS', N'rpt_Title_THOI_GIAN_CHAY_MAY_THEO_DC1', NULL, NULL, N'Thời gian chạy máy theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (503, N'CMMS', N'rpt_Title_THOI_GIAN_CHAY_MAY1', NULL, NULL, N'Thời gian chạy máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (504, N'CMMS', N'rptACTION_PLAN', NULL, NULL, N'Kế hoạch tổng thể')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (505, N'CMMS', N'rptBanDuTruDFC', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (506, N'CMMS', N'rptBAO_CAO_GIA', NULL, NULL, N'THÔNG TIN VỀ GIÁ VẬT TƯ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (507, N'CMMS', N'rptBAO_TRI_DINH_KY_CAN_THUC_HIEN', NULL, NULL, N'Bảo trì định kỳ cần thực hiện')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (508, N'CMMS', N'rptBAO_TRI_TRONG_NGAY', NULL, NULL, N'Phiếu bảo trì trong ngày')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (509, N'CMMS', N'rptBaoTriDinhKy', NULL, NULL, N'Bảo trì định kỳ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (510, N'CMMS', N'rptBaoTriDinhKyThang', NULL, NULL, N'Bảo trì định kỳ tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (511, N'CMMS', N'rptBaoTriDinhKyThangCS', NULL, NULL, N'Bảo trì định kỳ tháng (CS)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (512, N'CMMS', N'rptBien_Ban_Nghiem_Thu', NULL, NULL, N'Biên bản nghiệm thu phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (513, N'CMMS', N'rptBienBanGiaoNhanTaiSanCoDinh', NULL, NULL, N'Biên bản giao nhận tài sản (nội bộ)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (514, N'CMMS', N'rptBienBanGiaoNhanTaiSanCoDinhDV', NULL, NULL, N'Biên bản giao nhận tài sản')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (515, N'CMMS', N'rptBienBanNghiemThu', NULL, NULL, N'Biên bản nghiệm thu phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (516, N'CMMS', N'rptBIEU_DO_CHI_PHI_BAO_TRI', NULL, NULL, N'Biểu đồ chi phí bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (517, N'CMMS', N'rptBIEU_DO_CHI_PHI_MAINT_COST', NULL, NULL, N'Biểu đồ Maint Cost')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (518, N'CMMS', N'rptBIEU_DO_MAIN_HOUR', NULL, NULL, N'Biểu đồ Manhour')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (519, N'CMMS', N'rptBIEU_DO_THOI_GIAN_NGUNG_MAY', NULL, NULL, N'Biểu đồ thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (520, N'CMMS', N'rptBieuDohieuSuatLine', NULL, NULL, N'Biểu đồ hiệu suất sử dụng theo line ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (521, N'CMMS', N'rptBieuDoKhaNangSanSangLine', NULL, NULL, N'Biểu đồ khả năng sãn sàng theo Line ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (522, N'CMMS', N'rptBieuDoKPI', NULL, NULL, N'Biểu đồ chỉ số KPI')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (523, N'CMMS', N'rptBieudoMTBF_MTTR', NULL, NULL, N'MTBF AND MTTR CHART')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (524, N'CMMS', N'rptBieuDoTGNMTheoNNHours', NULL, NULL, N'Biểu đồ thời gian ngừng máy theo nguyên nhân (giờ)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (525, N'CMMS', N'rptBieuDoTGNMTheoNNPercent', NULL, NULL, N'Biểu đồ thời gian ngừng máy theo nguyên nhân (%)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (526, N'CMMS', N'rptBieudoTopTGNM', NULL, NULL, N'HIGHTEST DOWNTIME CHART')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (527, N'CMMS', N'rptBoPhanChiPhiReport', NULL, NULL, N'BUTGET SUMMARY REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (528, N'CMMS', N'rptBreakdownTime', NULL, NULL, N'Thời gian ngừng máy do hư hỏng theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (529, N'CMMS', N'rptCHI_PHI_BAO_TRI_THEO_BPCP', NULL, NULL, N'Chi phí bảo trì theo bộ phận chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (530, N'CMMS', N'rptCHI_PHI_BAO_TRI_THEO_DAY_CHUYEN', NULL, NULL, N'Chi phí bảo trì theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (531, N'CMMS', N'rptCHI_PHI_BAO_TRI_THEO_LOAI_TB', NULL, NULL, N'Chi phí bảo trì theo loại thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (532, N'CMMS', N'rptCHI_PHI_BAO_TRI_THEO_NHOM_TB', NULL, NULL, N'Chi phí bảo trì theo nhóm thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (533, N'CMMS', N'rptCHI_PHI_CUA_PBT', NULL, NULL, N'Bảng chi phí cho phiếu bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (534, N'CMMS', N'rptCHI_PHI_CUA_PBT_THEO_LOAI_BAO_TRI', NULL, NULL, N'Chi phí bảo trì theo loại bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (535, N'CMMS', N'rptCHI_PHI_CUA_PBT_THEO_LOAI_MAY', NULL, NULL, N'Chi phí bảo trì theo loại thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (536, N'CMMS', N'rptCHI_PHI_DICH_VU_THUE_NAI', NULL, NULL, N'Chi phí dịch vụ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (537, N'CMMS', N'rptCHI_PHI_PHU_TUNG_PBT', NULL, NULL, N'Chi phí phụ tùng cho bảo trì theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (538, N'CMMS', N'rptCHI_PHI_THEO_DAY_CHUYEN', NULL, NULL, N'Chi phí bảo trì theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (539, N'CMMS', N'rptChiPhiBaoTri', NULL, NULL, N'Chi phí bảo trì theo giai đoạn (Duy Tân)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (540, N'CMMS', N'rptChuKyHieuChuanKeTiep', NULL, NULL, N'Chu kỳ hiệu chuẩn kế tiếp')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (541, N'CMMS', N'rptChuKyHieuChuanKeTiepNoi_Nai', NULL, NULL, N'Danh sách thiết bị kiểm định')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (542, N'CMMS', N'rptChuKyHieuChuanNoi_Nai', NULL, NULL, N'Danh sách thiết bị có dụng cụ đo đã hiệu chuẩn, kiểm định trong năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (543, N'CMMS', N'rptCOMPARE_SO_LUONG_XUAT', NULL, NULL, N'Đối chiếu với kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (544, N'CMMS', N'rptCONG_VIEC_HANG_NGAY', NULL, NULL, N'CÔNG VIỆC HẰNG NGÀY')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (545, N'CMMS', N'rptCTY_DA_CUNG_CAP_VAT_TU', NULL, NULL, N'CÔNG TY ĐÃ CUNG CẤP VẬT TƯ PHỤ TÙNG')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (546, N'CMMS', N'rptDAILY_EQUIPMENT_EUEL', NULL, NULL, N'Daily equipmen fule & lubricant consumption report')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (547, N'CMMS', N'rptDAILY_SUMMARY_DMS', NULL, NULL, N'Phiếu công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (548, N'CMMS', N'rptDailyReport', NULL, NULL, N'Bảo trì trong ngày')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (549, N'CMMS', N'rptDANH_GIA_DICH_VU_KH', NULL, NULL, N'Bảng đánh giá nhà cung cấp dịch vụ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (550, N'CMMS', N'rptDANH_GIA_NCC', NULL, NULL, N'ĐÁNH GIÁ NHÀ CUNG CẤP')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (551, N'CMMS', N'rptDANH_GIA_NCC_EOR', NULL, NULL, N'ĐÁNH GIÁ NHÀ CUNG CẤP-EOR')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (552, N'CMMS', N'rptDANH_MUC_TAI_LIEU_THIET_BI_lbl_TMP', NULL, NULL, N'Danh sách tài liệu thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (553, N'CMMS', N'rptDANH_SACH_BP_CP_THIET_BI', NULL, NULL, N'Danh sách bộ phận chịu phí thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (554, N'CMMS', N'rptDANH_SACH_DC_THIET_BI_DUOC_LAP_DAT', NULL, NULL, N'Danh sách dây chuyền thiết bị được lắp đặt')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (555, N'CMMS', N'rptDANH_SACH_NOI_LAP_DAT_THIET_BI', NULL, NULL, N'Danh sách địa điểm lắp đặt của thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (556, N'CMMS', N'rptDANH_SACH_PHIEU_BAO_TRI_THEO_DIA_DIEM', NULL, NULL, N'Danh sách Phiếu bảo trì theo địa điểm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (557, N'CMMS', N'rptDANH_SACH_PHIEU_BAO_TRI_THEO_NGAY_CUOI', NULL, NULL, N'Danh sách Phiếu bảo trì theo ngày bảo trì cuối')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (558, N'CMMS', N'rptDANH_SACH_TAI_LIEU_THIET_BI', NULL, NULL, N'Danh sách tài liệu thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (559, N'CMMS', N'rptDANH_SACH_THIET_BI_GIA_KHI_MUA', NULL, NULL, N'Danh sách Thiết bị với giá trị khi mua ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (560, N'CMMS', N'rptDANH_SACH_VAT_TU_DE_BAO_TRI_TB', NULL, NULL, N'Danh sách vật tư phụ tùng sử dụng để bảo trì thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (561, N'CMMS', N'rptDanhsach_CV', NULL, NULL, N'DANH MỤC CÔNG VIỆC')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (562, N'CMMS', N'rptDanhsach_NCC', NULL, NULL, N'DANH SÁCH NHÀ CUNG CẤP')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (563, N'CMMS', N'rptDanhSach_ThietBi', NULL, NULL, N'DANH SÁCH THIẾT BỊ THEO LOẠI MÁY')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (564, N'CMMS', N'rptDanhsach_VTPT', NULL, NULL, N'DANH MỤC VẬT TƯ, PHỤ TÙNG')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (565, N'CMMS', N'rptDanhsach_VTPT_THEO_MAY', NULL, NULL, N'Danh mục phụ tùng theo thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (566, N'CMMS', N'rptDanhsach_VTPT_TheoMay', NULL, NULL, N'Danh mục phụ tùng theo thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (567, N'CMMS', N'rptDanhSachConHanBaoHanh', NULL, NULL, N'Danh sách thiết bị còn hạn bảo hành')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (568, N'CMMS', N'rptDanhSachConHanBaoHanh_Huda', NULL, NULL, N'Danh sách thiết bị còn hạn bảo hành (Huda)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (569, N'CMMS', N'rptDanhSachDHDDaHC', NULL, NULL, N'Danh sách thiết bị có dụng cụ đo đã hiệu chuẩn, kiểm định trong năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (570, N'CMMS', N'rptDanhSachHetHanBaoHanh', NULL, NULL, N'DANH SÁCH THIẾT BỊ HẾT HẠN BẢO HÀNH')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (571, N'CMMS', N'rptDanhSachNoiLapDatVaBPCPCuaThietBi', NULL, NULL, N'Danh sách địa điểm lắp đặt và BPCP của thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (572, N'CMMS', N'rptDanhSachPhieuNhap', NULL, NULL, N'Danh sách phiếu nhập kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (573, N'CMMS', N'rptDanhSachPhieuXuat', NULL, NULL, N'Danh sách phiếu xuất kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (574, N'CMMS', N'rptDanhSachPhieuXuatKho', NULL, NULL, N'Danh sách phiếu xuất kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (575, N'CMMS', N'rptDanhsachphutungdacbiet_KKTL', NULL, NULL, N'Danh mục thiết bị đặc biệt quan tâm (KKTL)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (576, N'CMMS', N'rptDanhsachphutungtheoDONVI_KKTL', NULL, NULL, N'Danh mục thiết bị theo đơn vị (KKTL)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (577, N'CMMS', N'rptDanhsachphutungtheoXuong_KKTL', NULL, NULL, N'Danh mục thiết bị theo phân xưởng (KKTL)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (578, N'CMMS', N'rptDanhsachTB_TheoDayChuyen', NULL, NULL, N'Danh sách thiết bị theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (579, N'CMMS', N'rptDanhSachTBHET_KH', NULL, NULL, N'DANH SÁCH THIẾT BỊ HẾT KHẤU HAO')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (580, N'CMMS', N'rptDanhSachThietBi', NULL, NULL, N'Danh sách thiết bị (tiêu đề)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (581, N'CMMS', N'rptDanhSachThietBiConKhauHao', NULL, NULL, N'DANH SÁCH THIẾT BỊ CÒN KHẤU HAO')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (582, N'CMMS', N'rptDanhSachThietBiDaHC', NULL, NULL, N'Danh sách thiết bị đã hiệu chuẩn, kiểm định theo năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (583, N'CMMS', N'rptDanhSachThietBiHetKhauHao', NULL, NULL, N'Danh sách thiết bị hết khấu hao')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (584, N'CMMS', N'rptDanhSachThietBiSuDungPhuTung', NULL, NULL, N'DANH SÁCH THIẾT BỊ SỬ DỤNG PHỤ TÙNG')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (585, N'CMMS', N'rptDanhSachThietBiTrongHeThong', NULL, NULL, N'DANH SÁCH THIẾT BỊ TRONG DÂY CHUYỀN')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (586, N'CMMS', N'rptDanhSachVTPT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (587, N'CMMS', N'rptDDH', NULL, NULL, N'Đơn đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (588, N'CMMS', N'rptDE_XUAT_MUA_HANG', NULL, NULL, N'Đề xuất mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (589, N'CMMS', N'rptDeNghiMuaHangDFC', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (590, N'CMMS', N'rptDeNghiNhapKhoDFC', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (591, N'CMMS', N'rptDeXuatMuaHang', NULL, NULL, N'Đề xuất mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (592, N'CMMS', N'rptDeXuatMuaHang_CS', NULL, NULL, N'Đề xuất mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (593, N'CMMS', N'rptDeXuatMuaHang_DUYTAN', NULL, NULL, N'Đề xuất mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (594, N'CMMS', N'rptDeXuatMuaHang_Image', NULL, NULL, N'Đề xuất mua hàng (Hình ảnh)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (595, N'CMMS', N'rptDeXuatMuaHangACE', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (596, N'CMMS', N'rptDeXuatMuaHangCS', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (597, N'CMMS', N'rptDeXuatMuaHangGRE', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (598, N'CMMS', N'rptDeXuatMuaHangNew', NULL, NULL, N'Đề xuất mua hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (599, N'CMMS', N'rptDeXuatMuaHangNF', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (600, N'CMMS', N'rptDonDatHang', NULL, NULL, N'Đơn đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (601, N'CMMS', N'rptDonDatHangACE', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (602, N'CMMS', N'rptDonDatHangCS', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (603, N'CMMS', N'rptDonDatHangNew', NULL, NULL, N'Đơn đặt hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (604, N'CMMS', N'rptDSBPChiuPhi', NULL, NULL, N'Danh sách bộ phận chịu phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (605, N'CMMS', N'rptDSCPBTTLoaiMay_DiaDiem', NULL, NULL, N'Danh sách phiếu bảo trì theo địa điểm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (606, N'CMMS', N'rptDSCPBTTLoaiMay_LoaiTB', NULL, NULL, N'Danh sách phiếu bảo trì theo loại thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (607, N'CMMS', N'rptDSCPBTTLoaiMay_LoaiTB1', NULL, NULL, N'Danh sách PBT theo loại máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (608, N'CMMS', N'rptDSCYCBTChuaNghiemThuTheoNV', NULL, NULL, N'Phiếu bảo trì chưa nghiệm thu theo nhân viên')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (609, N'CMMS', N'rptDSCYCBTDaNghiemThuTheoNV', NULL, NULL, N'Danh sách phiếu bảo trì đã nghiệm thu theo nhân viên')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (610, N'CMMS', N'rptDSPBTChuaNghiemThuTLBT', NULL, NULL, N'Danh sách PBT chưa nghiệm thu theo loại bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (611, N'CMMS', N'rptDSPBTDaNghiemThuTLBT', NULL, NULL, N'Danh sách phiếu bảo trì đã nghiệm thu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (612, N'CMMS', N'rptDSTB_TheoDayChuyen', NULL, NULL, N'Danh sách thiết bị theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (613, N'CMMS', N'rptDSTBAnToan', NULL, NULL, N'Danh sách thiết bị an toàn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (614, N'CMMS', N'rptDSTBAnToan1', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (615, N'CMMS', N'rptDSTBTNLDHienTai', NULL, NULL, N'Danh sách thiết bị theo nơi lắp đặt')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (616, N'CMMS', N'rptEOR1', NULL, NULL, N'EOR')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (617, N'CMMS', N'rptGIAM_SAT_TINH_TINH_TRANG_KHONG_DAT', NULL, NULL, N'DANH SÁCH THÔNG SỐ KHÔNG ĐẠT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (618, N'CMMS', N'rptGIAM_SAT_TINH_TRANG_DEN_HAN', NULL, NULL, N'DANH SÁCH THÔNG SỐ ĐẾN HẠN GIÁM SÁT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (619, N'CMMS', N'rptGIAM_SAT_TINH_TRANG_DIEN_BIEN_TS_GSTT', NULL, NULL, N'Diễn biến thông số giám sát tình trạng thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (620, N'CMMS', N'rptGiaphutungtheodonhang', NULL, NULL, N'Giá phụ tùng theo đơn hàng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (621, N'CMMS', N'rptHIEU_CHUAN_DHD', NULL, NULL, N'HIỆU CHUẨN DỤNG CỤ ĐO CỦA THIẾT BỊ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (622, N'CMMS', N'rptHIEU_CHUAN_MAY', NULL, NULL, N'HIỆU CHUẨN THIẾT BỊ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (623, N'CMMS', N'rptHIEU_SUAT_SU_DUNG_MAY', NULL, NULL, N'Hiệu suất sử dụng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (624, N'CMMS', N'rptHieuSuatSuDungMay', NULL, NULL, N'Hiệu suất sử dụng thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (625, N'CMMS', N'rptInAllPBT', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (626, N'CMMS', N'rptInBarCodeMay', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (627, N'CMMS', N'rptKE_HOACH_BAO_TRI_TRONG_TUAN', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (628, N'CMMS', N'rptKE_HOACH_BAO_TRI_TUAN', NULL, NULL, N'Kế hoạch bảo trì tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (629, N'CMMS', N'rptKE_HOACH_BAO_TRI_TUAN_He_Thong', NULL, NULL, N'Kế hoạch bảo trì trong tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (630, N'CMMS', N'rptKE_HOACH_BT_TUAN', NULL, NULL, N'Kế hoạch bảo trì tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (631, N'CMMS', N'rptKE_HOACH_TONG_THE', NULL, NULL, N'KẾ HOẠCH TỔNG THỂ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (632, N'CMMS', N'rptKE_HOACH_TONG_THE_PHU_TUNG', NULL, NULL, N'Xem tồn kho phụ tùng trong kế hoạch tổng thể')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (633, N'CMMS', N'rptKehoachbaotriduphong', NULL, NULL, N'Kế hoạch bảo trì dự phòng hàng năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (634, N'CMMS', N'rptKeHoachBaoTriTrongTuan', NULL, NULL, N'Kế hoạch bảo trì trong tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (635, N'CMMS', N'rptKeHoachBaoTriTuan', NULL, NULL, N'Kế hoạch bảo trì tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (636, N'CMMS', N'rptKeHoachBaoTriTuan_He_Thong', NULL, NULL, N'Kế hoạch bảo trì trong tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (637, N'CMMS', N'rptKeHoachGiamSatTinhTrang', NULL, NULL, N'Kế hoạch giám sát tình trạng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (638, N'CMMS', N'rptKeHoachGiamSatTinhTrang_BDL', NULL, NULL, N'Ke hoach giam sat tinh trang')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (639, N'CMMS', N'rptKeHoachPhanCongBT', NULL, NULL, N'Đề nghị và phân công bảo trì')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (640, N'CMMS', N'rptKeHoachSuaChuaThietBi', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (641, N'CMMS', N'rptKeHoachSuaChuaThietBi_KKTL', NULL, NULL, N'Kế hoạch bảo trì (KKTL)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (642, N'CMMS', N'rptKeHoachSuaChuaThietBi_KKTL_KHTT', NULL, NULL, N'Kế hoạch sửa chữa thiết bị(KKTL-KHTT)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (643, N'CMMS', N'rptKHA_NANG_SAN_SANG_THEO_THIET_BI', NULL, NULL, N'Khả năng sẵn sàng theo thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (644, N'CMMS', N'rptKIEM_KE_VAT_TU', NULL, NULL, N'Phiếu kiểm kê vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (645, N'CMMS', N'rptKiemKeVT_PT', NULL, NULL, N'Kiểm kê kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (646, N'CMMS', N'rptKiemKeVT_PTKgPN', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (647, N'CMMS', N'rptLICH_BAO_TRI_DINH_KI', NULL, NULL, N'Quy định bảo trì định kỳ của thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (648, N'CMMS', N'rptLICH_GIAM_SAT_TINH_TRANG_THIET_BI', NULL, NULL, N'Quy định giám sát tình trạng thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (649, N'CMMS', N'rptLICH_HIEU_CHUAN_THIET_BI', NULL, NULL, N'Quy định hiệu chuẩn thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (650, N'CMMS', N'rptLICH_SU_CAU_TRUC__THIET_BI', NULL, NULL, N'Lịch sử cấu trúc thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (651, N'CMMS', N'rptLICH_SU_PHU_TUNG', NULL, NULL, N'rptLICH_SU_PHU_TUNG')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (652, N'CMMS', N'rptLICH_SU_THIET_BI', NULL, NULL, N'Lịch sử thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (653, N'CMMS', N'rptLICH_SU_THIET_BI_KK', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (654, N'CMMS', N'rptLICH_SU_VAT_TU_SD_CHO_TB', NULL, NULL, N'Danh sách lịch sử vật tư được sử dụng cho thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (655, N'CMMS', N'rptMAINTENANCT_REPORT_MONTHLY', NULL, NULL, N'MONTHLY MAINTENANCE REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (656, N'CMMS', N'rptMaterialsSewingDailyReport', NULL, NULL, N'DAILY MAINTENANCE REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (657, N'CMMS', N'rptMDataTestMay', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (658, N'CMMS', N'rptMONTHLY_CONSUMPTION_INPUT_LIST', NULL, NULL, N'MAINTENANCE MATERIAL INPUT LIST')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (659, N'CMMS', N'rptMONTHLY_MAINTENANCE_MATERIAL_REPORT', NULL, NULL, N'MAINTENANCE MATERIAL REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (660, N'CMMS', N'rptMONTHLY_MATERIAL_OUTPUT_LIST', NULL, NULL, N'MAINTENANCE MATERIAL OUTPUT LIST')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (661, N'CMMS', N'rptMONTHLY_PO_APPROVED', NULL, NULL, N'MAINTENANCE MATERIAL PO APPROVED')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (662, N'CMMS', N'rptMTBF', NULL, NULL, N'Thời gian trung bình giữa hai lần hư hỏng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (663, N'CMMS', N'rptMThongTinSanPham', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (664, N'CMMS', N'rptMThongTinSanPham_KH', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (665, N'CMMS', N'rptNhanVien', NULL, NULL, N'Danh sách nhân viên')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (666, N'CMMS', N'rptNHAP_KHO_VAT_TU', NULL, NULL, N'NHẬP KHO VẬT TƯ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (667, N'CMMS', N'rptNOI_DUNG_GIAI_QUYET_HANG_MUC', NULL, NULL, N'Nội dung giải quyết nội dung kế hoạch')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (668, N'CMMS', N'rptPhanTichChiPhi', NULL, NULL, N'Phân tích chi phí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (669, N'CMMS', N'rptPhanTichChiPhi_DUYTAN', NULL, NULL, N'Phân tích chi phí(Duy Tân)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (670, N'CMMS', N'rptPhanTichGiaTriTonKho', NULL, NULL, N'Phân tích giá trị hàng tồn kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (671, N'CMMS', N'rptPHIEU_BAO_TRI', NULL, NULL, N'Phiếu bảo trì (chung)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (672, N'CMMS', N'rptPHIEU_BAO_TRI_AC', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (673, N'CMMS', N'rptPHIEU_BAO_TRI_BARIA', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (674, N'CMMS', N'rptPHIEU_BAO_TRI_BHS', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (675, N'CMMS', N'rptPHIEU_BAO_TRI_DHG', NULL, NULL, N'Phiếu bảo trì (DHG)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (676, N'CMMS', N'rptPHIEU_BAO_TRI_GRE', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (677, N'CMMS', N'rptPHIEU_BAO_TRI_MEKOPHAR', NULL, NULL, N' 5.4.1. Phiếu bảo trì Mekophar')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (678, N'CMMS', N'rptPHIEU_BAO_TRI_NT', NULL, NULL, N'Phiếu bảo trì (chung)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (679, N'CMMS', N'rptPHIEU_BAO_TRI_NT_HUDA', NULL, NULL, N'Phiếu bảo trì Huda (HUDA)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (680, N'CMMS', N'rptPHIEU_BAO_TRI_NT_KKTL', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (681, N'CMMS', N'rptPHIEU_BAO_TRI_NT_NUTIFOOD', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (682, N'CMMS', N'rptPHIEU_BAO_TRI_QUA_HAN_KT', NULL, NULL, N'Phiếu bảo trì quá hạn kết thúc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (683, N'CMMS', N'rptPHIEU_CONG_VIEC', NULL, NULL, N'Phiếu công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (684, N'CMMS', N'rptPhieuNhapACE', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (685, N'CMMS', N'rptPhieuNhapGRE', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (686, N'CMMS', N'rptPhieuNhapKhoNew', NULL, NULL, N' 6.1.12. Phiếu nhập kho vật tư')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (687, N'CMMS', N'rptPhieuNhapKhoNew_NTD', NULL, NULL, N'Phiếu nhập kho NTD')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (688, N'CMMS', N'rptPhieuNhapKhoVT_KKTL', NULL, NULL, N'rptPhieuNhapKhoVT_KKTL')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (689, N'CMMS', N'rptPhieuNhapKhoVTNew', NULL, NULL, N'Phiếu nhập kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (690, N'CMMS', N'rptPhieuNhapKhoX', NULL, NULL, N'Phiếu nhập xác')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (691, N'CMMS', N'rptPhieuThamDo', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (692, N'CMMS', N'rptPhieuXuatKhoX', NULL, NULL, N'Phiếu xuất xác')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (693, N'CMMS', N'rptPHU_TUNG_DUOC_CUNG_CAP_BOI_CTY', NULL, NULL, N'Danh sách nhà cung cấp của vật tư, phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (694, N'CMMS', N'rptPICK_LIST_CHI_TIET', NULL, NULL, N'Pick list')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (695, N'CMMS', N'rptQUI_DINH_VE_GSTT_THIET_BI', NULL, NULL, N'Quy định giám sát tình trạng thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (696, N'CMMS', N'rptROA1', NULL, NULL, N'ROA')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (697, N'CMMS', N'rptrptDANH_SACH_VTPT', NULL, NULL, N'Danh sách vật tư phụ tùng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (698, N'CMMS', N'rptSparePartDailyBudgetCheckList', NULL, NULL, N'Spare Part Daily Budget Check List')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (699, N'CMMS', N'rptTG_NgungMayTheoNam', NULL, NULL, N'Thời gian ngừng máy theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (700, N'CMMS', N'rptTG_NgungMayTheoNguyenNhan', NULL, NULL, N'Thời gian ngừng máy theo nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (701, N'CMMS', N'rptThamDinhThietBi', NULL, NULL, N'Thẩm định thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (702, N'CMMS', N'rptTheKho', NULL, NULL, N'Thẻ kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (703, N'CMMS', N'rptTHIET_BI_BAO_TRI_DINH_KY', NULL, NULL, N'Bảo trì định kỳ thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (704, N'CMMS', N'rptTHIET_BI_DEN_HAN_HIEU_CHUAN', NULL, NULL, N'Thiết bị đến hạn hiệu chuẩn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (705, N'CMMS', N'rptTHOI_GIAN_CHAY_MAY', NULL, NULL, N'THỜI GIAN CHẠY MÁY')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (706, N'CMMS', N'rptTHOI_GIAN_NGUNG_MAY', NULL, NULL, N'THỜI GIAN NGỪNG MÁY')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (707, N'CMMS', N'rptTHOI_GIAN_NGUNG_MAY_CHART', NULL, NULL, N'Biểu đồ thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (708, N'CMMS', N'rptTHOI_GIAN_NGUNG_MAY_THEO_MAY', NULL, NULL, N'Thời gian ngừng máy do hư hỏng theo loại thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (709, N'CMMS', N'rptTHOI_GIAN_NGUNG_MAY_THEO_NAM', NULL, NULL, N'Thời gian ngừng máy theo giai đoạn (Bản chung)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (710, N'CMMS', N'rptTHOI_GIAN_NGUNG_MAY_THEO_NGUYEN_NHAN', NULL, NULL, N'Thời gian ngừng máy theo nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (711, N'CMMS', N'rptTHOI_GIAN_SUA_CHUA_TB', NULL, NULL, N'Thời gian sửa chữa trung bình')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (712, N'CMMS', N'rptThoigianchaymay', NULL, NULL, N'Thời gian chạy máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (713, N'CMMS', N'rptThoiGianChayMayCuoiTuan', NULL, NULL, N'Thời gian chạy máy cuối tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (714, N'CMMS', N'rptthoigiansuachuatrungbinh', NULL, NULL, N'Thời gian sửa chữa trung bình')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (715, N'CMMS', N'rptthoigiansuachuatrungbinhgiua2lanhuhong', NULL, NULL, N'Thời gian trung bình giữa hai lần hư hỏng (New)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (716, N'CMMS', N'rptThoiGianTrongCuaThietBi', NULL, NULL, N'Thời gian trống của thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (717, N'CMMS', N'rptTHONG_TIN_CHUNG_VA_THONG_SO_TB', NULL, NULL, N'Thông tin chung và thông số thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (718, N'CMMS', N'rptThongKeTanSuatNgungMay', NULL, NULL, N'Tần suất ngừng máy theo giai đoạn (Duy Tân)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (719, N'CMMS', N'rptThongKeTanSuatNgungMay_NEW', NULL, NULL, N'Tần suất ngừng máy theo giai đoạn (New)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (720, N'CMMS', N'rptThongKeThoiGianNgungMay', NULL, NULL, N'Thời gian ngừng máy theo giai đoạn (Duy Tân) ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (721, N'CMMS', N'rptThongKeThoiGianNgungMayTheoNguyenNhan', NULL, NULL, N'Tổng hợp thời gian ngừng máy theo nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (722, N'CMMS', N'rptThongKeXuatVatTu', NULL, NULL, N'Thống kê xuất vật tư')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (723, N'CMMS', N'rptThongso_GSTT_DHKT', NULL, NULL, N'Thông số giám sát đến hạn kiểm tra')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (724, N'CMMS', N'rptTIEU_DE_BTDK', NULL, NULL, N'Bảo trì định kỳ (tiêu đề)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (725, N'CMMS', N'rptTIEU_DE_DANH_GIA_DICH_VU_KH', NULL, NULL, N'Bảng đánh giá nhà cung cấp dịch vụ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (726, N'CMMS', N'rptTIEU_DE_DU_TRU_VT_THEO_DAY_CHUYEN', NULL, NULL, N'Dự trù vật tư theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (727, N'CMMS', N'rptTIEU_DE_DU_TRU_VT_THEO_MAY', NULL, NULL, N'Dự trù vật tư theo máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (728, N'CMMS', N'rptTieuDeDanhSachDHDDaHC', NULL, NULL, N'Danh sách thiết bị có dụng cụ đo đã hiệu chuẩn, kiểm định trong năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (729, N'CMMS', N'rptTieuDeTG_NgungMayTheoNguyenNhan', NULL, NULL, N'Thời gian ngừng máy theo nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (730, N'CMMS', N'rptTINH_TRANG_THIET_BI', NULL, NULL, N'Tình trạng thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (731, N'CMMS', N'rptTinhHinhSuaChuaThietBi_KKTL', NULL, NULL, N'Báo cáo tình hình sửa chữa thiết bị (KKTL)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (732, N'CMMS', N'rpttitle', NULL, NULL, N'rpttitle')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (733, N'CMMS', N'rptTitlereport', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (734, N'CMMS', N'rptTON_KHO_EOR', NULL, NULL, N'THÔNG TIN TỒN KHO')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (735, N'CMMS', N'rptTON_KHO_KHONG_THEO_VI_TRI', NULL, NULL, N'TỒN KHO KHÔNG THEO VỊ TRÍ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (736, N'CMMS', N'rptTON_KHO_THEO_PHIEU_NHAP', NULL, NULL, N'TỒN KHO THEO PHIẾU NHẬP')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (737, N'CMMS', N'rptTON_KHO_THEO_VI_TRI', NULL, NULL, N'TỒN KHO THEO VỊ TRÍ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (738, N'CMMS', N'rptTON_KHO_THEO_VI_TRI_BAYER', NULL, NULL, N'Báo cáo tồn kho theo vị trí')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (739, N'CMMS', N'rptTonKhoTheoDayChuyen', NULL, NULL, N'Tồn kho phụ tùng theo dây chuyền')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (740, N'CMMS', N'rptTRUC_CA', NULL, NULL, N'Trực ca')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (741, N'CMMS', N'rptucVTChuaXuatKho', NULL, NULL, N'Danh sách vật tư chưa xuất kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (742, N'CMMS', N'rptucVTKhongThayThe', NULL, NULL, N'Danh sách vật tư không thay thế')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (743, N'CMMS', N'rptucVTKhongXuatKho', NULL, NULL, N'Danh sách vật tư không xuất kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (744, N'CMMS', N'rptVAT_TU_XUAT_KHO', NULL, NULL, N'Thống kê vật tư, phụ tùng xuất kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (745, N'CMMS', N'rptVENDOR_REPORT_OD_RECEIPT', NULL, NULL, N'MAINTENANCE VENDORS ODS RECEIPT REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (746, N'CMMS', N'rptVENDOR_REPORT_PURCHASING_ORDER', NULL, NULL, N'MAINTENANCE VENDORS PO REPORT')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (747, N'CMMS', N'rptVTPT_NHO_HON_TON_TOI_THIEU', NULL, NULL, N'Vật tư phụ tùng có tồn kho nhỏ hơn tồn tối thiểu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (748, N'CMMS', N'rptWEP_REPORT', NULL, NULL, N'Thông tin thiết bị trong tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (749, N'CMMS', N'rptXUAT_KHO_VAT_TU', NULL, NULL, N'XUẤT KHO VẬT TƯ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (750, N'CMMS', N'rptXUAT_KHO_VAT_TU_ACE', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (751, N'CMMS', N'rptYeucauNguoiSuDung', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (752, N'CMMS', N'ucAccessory', NULL, NULL, N'Báo cáo vật tư sử dụng cho thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (753, N'CMMS', N'ucBangKeChiTietVatTu', NULL, NULL, N'Bảng kê vật tư chi tiết (Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (754, N'CMMS', N'ucBangKeCTNhapKho', NULL, NULL, N'Bảng kê chi tiết vật tư nhập kho(Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (755, N'CMMS', N'ucBangKeXNTKhoChin', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (756, N'CMMS', N'ucBangKeXNTKhoChinh', NULL, NULL, N'Xuất nhập tồn (Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (757, N'CMMS', N'ucBaoCaoBaoTriThietBi', NULL, NULL, N'Báo cáo bảo trì thiết bị tại chi nhánh(Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (758, N'CMMS', N'ucBaoCaoBaoTriThietBiTuan', NULL, NULL, N'Báo cáo bảo trì thiết bị tuần tại chi nhánh(Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (759, N'CMMS', N'ucBaoCaoChiPhiChiTiet', NULL, NULL, N'Chi phí bảo trì chi tiết')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (760, N'CMMS', N'ucBaoCaoCongViecBaoTri', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (761, N'CMMS', N'ucBaoCaoPhieuCongViec', NULL, NULL, N'Phiếu công việc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (762, N'CMMS', N'ucBaoCaoYCNSD', NULL, NULL, N'Tổng hợp yêu cầu người sử dụng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (763, N'CMMS', N'ucBCPhieuKiemTraMayHN', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (764, N'CMMS', N'ucBCPhuTungDGCuoi', NULL, NULL, N'Danh sách phụ tùng với đơn giá cuối')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (765, N'CMMS', N'ucBCTHThoiGianNgungMay', NULL, NULL, N'Thời gian ngừng máy')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (766, N'CMMS', N'ucBCTonKho', NULL, NULL, N'Material and Spare part inventory')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (767, N'CMMS', N'ucBCTonKhoSum', NULL, NULL, N'Material and Spare part inventory summary')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (768, N'CMMS', N'ucBieuDoChiPhiTheoNX', NULL, NULL, N'Biểu đồ chi phí tổng hợp theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (769, N'CMMS', N'ucBieuDoChiPhiTheoNXThang', NULL, NULL, N'Biểu đồ chi phí tổng hợp theo tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (770, N'CMMS', N'ucBieuDoChiPhiTheoTB', NULL, NULL, N'Biểu đồ chi phí của thiết bị theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (771, N'CMMS', N'ucBieuDoChiPhiTheoThang', NULL, NULL, N'Biểu đồ chi phí của thiết bị qua từng tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (772, N'CMMS', N'ucBieuDoTGNMayTheoMay', NULL, NULL, N'Biểu đồ thời gian ngừng máy của thiết bị theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (773, N'CMMS', N'ucBieuDoTGNMayTheoNX', NULL, NULL, N'Biểu đồ thời gian ngừng máy tổng hợp theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (774, N'CMMS', N'ucBieuDoTGNMayTheoNXThang', NULL, NULL, N'Biểu đồ thời gian ngừng máy tổng hợp theo tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (775, N'CMMS', N'ucBieuDoTGNMayTheoThang', NULL, NULL, N'Biểu đồ thời gian ngừng máy của thiết bị theo tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (776, N'CMMS', N'ucDanhMucMayMocThietBi', NULL, NULL, N'Danh mục máy móc thiết bị (Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (777, N'CMMS', N'ucDanhMucThietBiDoAp', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (778, N'CMMS', N'ucDanhSachVTPT', NULL, NULL, N'Danh sách vật tư phụ tùng tiêu hao')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (779, N'CMMS', N'ucDeXuatVatTu', NULL, NULL, N'Dự toán vật tư chi tiết (Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (780, N'CMMS', N'ucDieuChinhThietBi', NULL, NULL, N'Báo cáo điều chuyển thiết bị (IT)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (781, N'CMMS', N'ucDMTBKiemDinh', NULL, NULL, N'Danh mục thiết bị kiểm định(Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (782, N'CMMS', N'ucDSBaoTri', NULL, NULL, N'Tổng hợp tình hình bảo trì thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (783, N'CMMS', N'ucDSPNTreHoaDon', NULL, NULL, N'Danh sách phiếu nhập bị trễ hóa đơn (Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (784, N'CMMS', N'ucDSTBTheoDiaDiem', NULL, NULL, N'Danh sách thiết bị theo địa điểm (IT)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (785, N'CMMS', N'ucDuToanTheoDonVi', NULL, NULL, N'Dự toán vật tư tổng hợp (Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (786, N'CMMS', N'ucFastSlowNonMovingAnalysic', NULL, NULL, N'Phân tích FSN')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (787, N'CMMS', N'ucHCKD', NULL, NULL, N'Kế hoạch hiệu chuẩn kiểm dịnh')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (788, N'CMMS', N'ucIncident', NULL, NULL, N'Bảng thống kê thông tin sự cố - bảo trì tủ hàng tháng theo tỷ lệ')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (789, N'CMMS', N'ucIncident_Detai', NULL, NULL, N'Bảng thống kê thông tin sự cố tủ chi tiết')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (790, N'CMMS', N'ucIncidents_Non_Recurring', NULL, NULL, N'Bảng thống kê sự cố theo nguyên nhân')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (791, N'CMMS', N'ucKeHoachBaoDuong', NULL, NULL, N'Kế hoạch bảo dưỡng tháng (Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (792, N'CMMS', N'ucKeHoachBaoTriNam', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (793, N'CMMS', N'ucKeHoachBaoTriNamSSD', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (794, N'CMMS', N'ucKeHoachBatTriNamNutifood', NULL, NULL, N'Kế hoạch bảo trì hằng năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (795, N'CMMS', N'UCKeHoachBT_Kido', NULL, NULL, N'Kế hoạch bảo trì tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (796, N'CMMS', N'UCKeHoachBT_Nam', NULL, NULL, N'Kế hoạch bảo trì năm (NMNTD)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (797, N'CMMS', N'UCKeHoachBT_Thang', NULL, NULL, N'Kế hoạch bảo trì tháng (NMNTD)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (798, N'CMMS', N'ucKeHoachBTTuan', NULL, NULL, N'Kế hoạch bảo trì tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (799, N'CMMS', N'ucKeHoachCongViecBaoTri', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (800, N'CMMS', N'ucKeHoachKiemDinhNam', NULL, NULL, N'Kế hoạch hiệu chuẩn kiểm định năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (801, N'CMMS', N'ucKeHoachKiemDinhThang', NULL, NULL, N'Kế hoạch hiệu chuẩn kiểm định tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (802, N'CMMS', N'ucKeHoachNam', NULL, NULL, N'Kế hoạch bảo trì năm')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (803, N'CMMS', N'ucKeHoachTuan', NULL, NULL, N'Kế hoạch bảo trì tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (804, N'CMMS', N'ucKHBDThietBi', NULL, NULL, N'Kế hoạch bảo dưỡng năm (Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (805, N'CMMS', N'ucKHKDThietBi', NULL, NULL, N'Kế hoạch hiệu chuẩn kiểm định')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (806, N'CMMS', N'ucKHKDThietBi1', NULL, NULL, N'Kế hoạch hiệu chuẩn kiểm định')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (807, N'CMMS', N'ucKHKiemDinhBenNai', NULL, NULL, N'Kế hoạch hiệu chuẩn kiểm định bên nài')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (808, N'CMMS', N'ucLuanChuyenVatTu', NULL, NULL, N'Báo cáo công tác luân chuyển vật tư phụ tùng(Acecook)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (809, N'CMMS', N'ucMachineUseAccessory', NULL, NULL, N'Bảng thống kê vật tư sử dụng hàng tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (810, N'CMMS', N'ucMailBaoTriDinhKyThangCS', NULL, NULL, N'Kế hoạch bảo trì định kỳ tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (811, N'CMMS', N'ucMailBieuDoChiPhiTheoNX', NULL, NULL, N'Biểu đồ chi phí tổng hợp theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (812, N'CMMS', N'ucMailBieuDoChiPhiTheoNXThang', NULL, NULL, N'Biểu đồ chi phí tổng hợp theo tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (813, N'CMMS', N'ucMailBieuDoChiPhiTheoTB', NULL, NULL, N'Biểu đồ chi phí của thiết bị theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (814, N'CMMS', N'ucMailBieuDoChiPhiTheoTBThang', NULL, NULL, N'Biểu đồ chi phí của thiết bị theo tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (815, N'CMMS', N'ucMailBieuDoTGNMayTheoMay', NULL, NULL, N'Biểu đồ thời gian ngừng máy của thiết bị theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (816, N'CMMS', N'ucMailBieuDoTGNMayTheoMayThang', NULL, NULL, N'Biểu đồ thời gian ngừng máy của thiết bị theo tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (817, N'CMMS', N'ucMailBieuDoTGNMayTheoNX', NULL, NULL, N'Biểu đồ thời gian ngừng máy tổng hợp theo giai đoạn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (818, N'CMMS', N'ucMailBieuDoTGNMayTheoNXThang', NULL, NULL, N'Biểu đồ thời gian ngừng máy tổng hợp theo tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (819, N'CMMS', N'ucMailBTDKCThucHien', NULL, NULL, N'Bảo trì định kỳ cần thực hiện')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (820, N'CMMS', N'ucMailChuaCoHoaDon', NULL, NULL, N'Danh sách phiếu nhập chưa có hóa đơn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (821, N'CMMS', N'ucMailPGSTTDHKT', NULL, NULL, N'Giám sát tình trạng đến hạn kiểm tra')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (822, N'CMMS', N'ucMailVatTuDeXuatChuaNhapKho', NULL, NULL, N'Vật tư đề xuất chưa nhập kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (823, N'CMMS', N'UCMaintaince', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (824, N'CMMS', N'UCMaintainceFor_Day_Of_Week', NULL, NULL, N'Kế hoạch bảo trì thiết bị trong tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (825, N'CMMS', N'UCMaintainceFor3Months_Huda', NULL, NULL, N'Kế hoạch bảo trì định kỳ thiết bị')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (826, N'CMMS', N'UCMaintainceForMonth_Huda', NULL, NULL, N'Kế hoạch bảo trì thiết bị trong tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (827, N'CMMS', N'UCMaintainceForWeek', NULL, NULL, N'Kế hoạch bảo trì định kỳ hàng tuần')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (828, N'CMMS', N'ucMaintainMonth', NULL, NULL, N'Kế hoạch bảo trì tháng')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (829, N'CMMS', N'ucMTest', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (830, N'CMMS', N'ucMTTRMTBF', NULL, NULL, N'MTBF AND MTTR CHART (TAPACK)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (831, N'CMMS', N'ucNhapXuatTon', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (832, N'CMMS', N'ucNSKido', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (833, N'CMMS', N'ucPBTQuaHanKT', NULL, NULL, N'Phiếu bảo trì quá hạn kết thúc')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (834, N'CMMS', N'ucPBTTrongNgay', NULL, NULL, N'Phiếu bảo trì trong ngày')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (835, N'CMMS', N'UCReportInfo', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (836, N'CMMS', N'UCrptXuatNhapKho', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (837, N'CMMS', N'ucSafetyStock', NULL, NULL, N'Tồn kho an toàn')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (838, N'CMMS', N'ucSentTo', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (839, N'CMMS', N'ucTanSuatSuDungPhuTung', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (840, N'CMMS', N'ucThietBiDenHanHieuChuan', NULL, NULL, N'Thiết bị đến hạn HC')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (841, N'CMMS', N'ucThongKeKiemtraBarcode', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (842, N'CMMS', N'ucTongHopBaoCaoNXLMDC', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (843, N'CMMS', N'ucTongHopPhieuBaoTri', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (844, N'CMMS', N'ucTyLeBaoTriTrucTiep', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (845, N'CMMS', N'ucVatTuDeXuatChuaNhapKho', NULL, NULL, N'VẬT TƯ ĐỀ XUẤT CHƯA NHẬP KHO')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (846, N'CMMS', N'ucVTChuaXuatKho', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (847, N'CMMS', N'ucVTKhongThayThe', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (848, N'CMMS', N'ucVTPTSLTonNhohonTTT', NULL, NULL, N'VT PT có SL tồn nhỏ hơn SL tồn tối thiểu')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (849, N'CMMS', N'ucVTXuatTheoNhap', NULL, NULL, N'Thống kê vật tư xuất theo thời gian nhập kho')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (850, N'CMMS', N'UCWarranty', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (851, N'CMMS', N'UCXuatNhapTon_TD', NULL, NULL, N'Báo cáo tồn kho (NTD)')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (852, N'CMMS', N'XtraForm1', NULL, NULL, N'Form test báo cáo')

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (853, N'CMMS', N'XtraForm7', NULL, NULL, NULL)

INSERT [dbo].[DS_FORM] ([ID], [DLL_NAME], [FORM_NAME], [LINK_BH], [LINK_VIDEO], [DESCRIPTION]) VALUES (854, N'CMMS', N'XtraShape', NULL, NULL, N'XtraShape')

SET IDENTITY_INSERT [dbo].[DS_FORM] OFF

