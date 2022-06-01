define(['_MasterPageController', '_MenuPageController', '_DetailsModalController', 'datatables-bootstrap', 'bootstrap-select'], function (module, menu, modal) {
    var LeaderShip = (function () {
        var app = angular.module('LeaderShipPage', [])
        app.controller('LeaderShipController', function ($scope, $compile) {
            var Main = module.Main
            var Languages = module.Languages
            var Convert = module.Convert
            var InfoDetails = modal
            var Loading = module.Loading
            var Alert = module.Alert
            var MainMenu = menu
            var BuildTreeView = module.BuildTreeView
            var menuID = 'mnuLeaderShip'
            var currentNamePage = 'LeaderShipWeb'
            var change = false
            var buttonFloat = [
                {
                    "id": "btnMain",
                    "url": "#",
                    "icon": "<i class='fa fa-angle-double-up'></i>"
                },
                {
                    "id": "btnXoa",
                    "url": "#",
                    "icon": "<i class='fa fa-minus-square'></i>",
                    "lang": "btndelete",
                    "func": "fn.Remove"
                },
                {
                    "id": "btnSave",
                    "url": "#",
                    "icon": "<i class='fa fa-floppy-o'></i>",
                    "lang": "btnGhi",
                    "func": "fn.CheckValidateControl"
                },
                {
                    "id": "btnRefresh",
                    "icon": "<i class='fa fa-refresh'></i>",
                    "lang": "btnRefresh",
                    "url": urlResetLeaderShip
                }
            ]
            var Action = {
                add: 0, edit: 1
            }
            var vars = {}
            var bindVariables = function () {
                return {
                    $action: Action.add,
                }
            }
            var fnPrivate = {
                LoadLeaderShipDetails: function () {
                    if (change == false) return;
                    Loading.fn.Show();
                    $.post(urlGetLeaderShip, { TuNgay: $("#fromDate").val(), User: $("#cbReport").val(), LoaiBC: $("#cboLoaiBC").val()}, function (data) {
                        if ($.fn.DataTable.isDataTable('#tbShowListDeails')) {
                            $('#tbShowListDeails').dataTable().fnDestroy();
                        }
                        $('#tbShowListDeails tbody').empty();
                        if (data.length > 0) {
                            var i = 0;
                            for (i = 0; i < data.length; i++) {
                                $('#tbShowListDeails tbody').append('<tr data-id="' + data[i].IDLeadership + '"><td style="width:15px; text-align:center">'
                                    + data[i].STT + '</td><td class="hidden">'
                                    + data[i].IDLeadership + '</td ><td>'
                                    + data[i].Content + '</td><td><textarea class= "form-control" id = "txtGhiChu" style="margin-top: 0px; margin-bottom: 0px; height: 30px;" >'
                                    + (data[i].NOTE == null ?"":data[i].NOTE)+'</textarea></td ><td style="width:15px; text-align:center"><input type="checkbox" class="custom-control-input" '
                                    + (data[i].Yes == true ? "checked" : "") + ' data-chon="yes"></td><td style="width:15px; text-align:center"><input type="checkbox" class="custom-control-input"'
                                    + (data[i].No == true ? "checked" : "") + ' data-chon="no"></td><td style="width:15px; text-align:center"><input type="checkbox" class="custom-control-input "'
                                    + (data[i].NA == true ? "checked" : "") + ' data-chon="na"></td></tr>');
                            }
                        }
                        Loading.fn.Hide();
                    });
                }
            }

            var method
            $scope.fn = {
                Init: function () {
                    global.CurrentNamePage = currentNamePage
                    MainMenu.fn.SetActive(menuID);
                    Languages.fn.AutoChangeLanguage()
                    Main.fn.InitButtonFloat(buttonFloat)
                    vars = bindVariables();
                    method = fnPrivate;
                    change = false;
                    Main.fn.InitDateTimePickerChanged([$('#fromDate')], method.LoadLeaderShipDetails);
                    $('#cbReport').val($('#txtCreatedBy').val()).change();
                    $('#cbReport').change(function () {
                        method.LoadLeaderShipDetails();
                    })
                    $('#cboLoaiBC').change(function () {
                        method.LoadLeaderShipDetails();
                    })
                    $("#cbReport").select2(
                        {
                            theme: "classic"
                        });
                    $("#cboLoaiBC").select2(
                        {
                            theme: "classic"
                        });
                    change = true;
                    method.LoadLeaderShipDetails();


                    $('#tbShowListDeails tbody').on('click', 'tr td input', function () {
                        var rowchon = $(this).parent().parent().attr("data-id");
                        if ($(this).is(":checked")) {
                            if ($(this).attr("data-chon") == 'yes') {
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon + '"] td input[type=checkbox][data-chon="no"]').prop('checked', false);
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon + '"] td input[type=checkbox][data-chon="na"]').prop('checked', false);
                            }

                            if ($(this).attr("data-chon") == 'no') {
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon + '"] td input[type=checkbox][data-chon="yes"]').prop('checked', false);
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon + '"] td input[type=checkbox][data-chon="na"]').prop('checked', false);
                            }

                            if ($(this).attr("data-chon") == 'na') {
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon + '"] td input[type=checkbox][data-chon="no"]').prop('checked', false);
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon + '"] td input[type=checkbox][data-chon="yes"]').prop('checked', false);
                            }
                        }
                    });
                },
                CheckValidateControl: function () {

                    if ($('#cbReport').val() !== $('#txtCreatedBy').val()) {
                        Alert.fn.Show(global.TypeLanguage == 0 ? "Bạn không được báo cáo cho người khác!" : "You must not report to others!", Alert.Type.warning);
                        return false;
                    }

                    var lstLeadDetails = new Array();
                    var i = 0;
                    $('#tbShowListDeails tbody tr').each(function (i, obj) {
                        if (!this.rowIndex) return;
                        lstLeadDetails[i] = new Object();
                        lstLeadDetails[i].ID = $(this).attr('data-id');
                        lstLeadDetails[i].STT = this.cells[0].innerHTML;
                        lstLeadDetails[i].IDLeadership = this.cells[1].innerHTML;
                        lstLeadDetails[i].Content = this.cells[2].innerHTML;
                        lstLeadDetails[i].NOTE = $(obj).closest('tr').find('textarea').val();
                        lstLeadDetails[i].Yes = $(obj).closest('tr').find('input[type=checkbox][data-chon="yes"]').is(":checked");
                        lstLeadDetails[i].No = $(obj).closest('tr').find('input[type=checkbox][data-chon="no"]').is(":checked");
                        lstLeadDetails[i].NA = $(obj).closest('tr').find('input[type=checkbox][data-chon="na"]').is(":checked");
                        i = i + 1;
                    });
                    var stringData1 = JSON.stringify(lstLeadDetails).replace(/[\n\t]/g, " ");
                    $.ajax({
                        url: urlSaveLeaderShip,
                        type: "post",
                        data: { TuNgay: $("#fromDate").val(), User: $("#cbReport").val(), LoaiBC: $("#cboLoaiBC").val(), DataDetails: stringData1 },
                        success: function (data) {
                            if (data.Message === 'success') {
                                Alert.fn.Show(global.TypeLanguage == 0 ? "Thêm chứng từ thành công!" : "Add certificate to public!", Alert.Type.success);
                            }
                            else {
                                Alert.fn.Show(global.TypeLanguage == 0 ? "Cập nhật chứng từ không thành công!" : "Update voucher failed!", Alert.Type.error);
                            }
                        }
                    });
                },
                Remove: function () {
                    if ($('#cbReport').val() !== $('#txtCreatedBy').val()) {
                        Alert.fn.Show(global.TypeLanguage == 0 ? "Bạn không được xóa!" : "You can't delete!", Alert.Type.warning);
                        return false;
                    }
                    Alert.fn.ShowConfirm(global.TypeLanguage == 0 ? "Bạn có chắc muốn xóa?" : "Are you sure you want to delete?", Alert.Type.question, 'Xóa', function (result) {
                        if (result === true) {
                            $.post(urlDeleteLeaderShip, { TuNgay: $("#fromDate").val(), User: $("#cbReport").val(), LoaiBC: $("#cboLoaiBC").val()}, function (data) {
                                if (data === 'success') {
                                    window.location.href = urlResetLeaderShip;
                                } 
                                else {
                                    Alert.fn.Show(global.TypeLanguage == 0 ? "Xóa chứng từ không thành công!" : "Failed to delete voucher!", Alert.Type.error);
                                }
                            });
                        }
                    });
                }
            }
        })
        app.init = function () {
            angular.bootstrap(document, ['LeaderShipPage'])
        }
        return app;
    })();
    $(function () {
        LeaderShip.init()
    });
})