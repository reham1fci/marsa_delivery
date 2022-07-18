class Target{
  String? yourDailyTarget ="0";
  String? requiredDailyTarget ="0";
  String? yourWeeklyTarget="0";
  String? requiredWeeklyTarget ="0";
  String? yourMonthlyTarget ="0";
  String? requiredMonthlyTarget ="0";

  Target({
      this.yourDailyTarget,
      this.requiredDailyTarget,
      this.yourWeeklyTarget,
      this.requiredWeeklyTarget,
      this.yourMonthlyTarget,
      this.requiredMonthlyTarget});

  factory Target.fromJson(Map<String  ,dynamic> json ){
    return Target(

      //receiver: json["name"] ,
        requiredDailyTarget:   json["daily_required_target"],
        requiredMonthlyTarget:json["monthly_required_target"],
        requiredWeeklyTarget:  json["weekly_required_target"],
        yourDailyTarget:json["daily_target_detective"],
        yourMonthlyTarget:json["monthly_target_detective"],
        yourWeeklyTarget :json["weekly_target_detective"],

    );
  }
}