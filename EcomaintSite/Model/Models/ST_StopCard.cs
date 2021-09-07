namespace Model.Data
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ST_StopCard
    {
        public int ID { get; set; }
        [StringLength(50)]
        public string DocNum { get; set; }

        public DateTime? DocDate { get; set; }

        public DateTime? DocTime { get; set; }

        public bool? AdjPerPPE { get; set; }

        public bool? StopJob { get; set; }

        public bool? ChangingPosition { get; set; }

        public bool? RearrangingJob { get; set; }

        public bool? AttachingGrouds { get; set; }

        public bool? PerformingLocks { get; set; }

        public bool? OtherReaction { get; set; }

        public bool? Head { get; set; }

        public bool? ArmsAndHands { get; set; }

        public bool? EyesAndFace { get; set; }

        public bool? Trunk { get; set; }

        public bool? Ears { get; set; }

        public bool? LegsAndFeet { get; set; }

        public bool? RespiratorySystem { get; set; }

        public bool? OtherPPE { get; set; }

        public bool? HPES1 { get; set; }

        public bool? HPES2 { get; set; }

        public bool? HPES3 { get; set; }

        public bool? HPES4 { get; set; }

        public bool? HPES5 { get; set; }

        public bool? HPES6 { get; set; }

        public bool? StrikingAgaintObjects { get; set; }

        public bool? ChokingHazardousAir { get; set; }

        public bool? CaughtInOn { get; set; }

        public bool? Inhaling { get; set; }

        public bool? Falling { get; set; }

        public bool? RepettiveMotions { get; set; }

        public bool? Contacting { get; set; }

        public bool? PositionsToWork { get; set; }

        public bool? ContactSharpObject { get; set; }

        public bool? FlyingObjects { get; set; }

        public bool? ContactingElectric { get; set; }

        public bool? EmployeeWork { get; set; }

        public bool? NotRight { get; set; }

        public bool? Unknow { get; set; }

        public bool? UsedIncorrectly { get; set; }

        public bool? NotUnderstood { get; set; }

        public bool? InUnsafeCondition { get; set; }

        public bool? NotFlowed { get; set; }

        public bool? NotAequate { get; set; }

        public bool? OtherProcedure { get; set; }

        public bool? OtherTools { get; set; }

        public bool? NotIsolate { get; set; }

        public bool? ToolAndEquipment { get; set; }

        public bool? NoCollectGarbage { get; set; }

        public bool? EmergencyExit { get; set; }

        public bool? Slip { get; set; }

        public bool? OtherOderLine { get; set; }

        [StringLength(250)]
        public string CreatedBy { get; set; }

        public bool? External { get; set; }

        public bool? DUNG_CU_THIET_BI { get; set; }

        public bool? KHU_VUC_LAM_VIEC { get; set; }

        public bool? MOI_TRUONG_LAM_VIEC { get; set; }

        public bool? SACH_SE_NGAN_NAP { get; set; }

        public string LOAI_CONG_VIEC { get; set; }

        public string HO_TEN_CA_NHAN_TO_NHOM { get; set; }

        public string HANH_DONG_HANH_VI_AN_TOAN { get; set; }

        public string HANH_VI_KHONG_AN_TOAN { get; set; }

        public string KHAC_PHUC_TUC_THI { get; set; }

        [StringLength(250)]
        public string APPROVAL_USER { get; set; }

        public bool? IS_APPROVED { get; set; }

        public string TOtherOrderliness { get; set; }

        public string TOtherPPE { get; set; }

        public string TOtherProcedure { get; set; }

        public string TOtherReactions { get; set; }

        public string TOtherToolAndEquipment { get; set; }

        public string Description { get; set; }

        [StringLength(300)]
        public string REPORT_PARENT { get; set; }

        public string IMG_PATCH1 { get; set; }

        public string IMG_PATCH2 { get; set; }

        public bool? IS_DELETE { get; set; }

        [StringLength(300)]
        public string NGUOILIENQUAN1 { get; set; }

        [StringLength(300)]
        public string NGUOILIENQUAN2 { get; set; }

        [Column(TypeName = "image")]
        public byte[] Image_1 { get; set; }
    }
}
