// ============================================================
// Employee Attrition - Power Query (M)
// Create each block as its own query via Home > New Source > Blank Query > Advanced Editor
// Original CSV is never modified. Employees REFERENCES Raw_Attrition.
// ============================================================

// ---------- Parameter: FilePath (type Text) ----------
// "C:\Data\attrition.csv" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]

// ---------- Query 1: Raw_Attrition (right-click > uncheck Enable load) ----------
let
    Source   = Csv.Document(File.Contents(FilePath), [Delimiter=",", Columns=35, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Typed    = Table.TransformColumnTypes(Promoted, {
        {"Age", Int64.Type}, {"Attrition", type text}, {"BusinessTravel", type text}, {"DailyRate", Int64.Type},
        {"Department", type text}, {"DistanceFromHome", Int64.Type}, {"Education", Int64.Type}, {"EducationField", type text},
        {"EmployeeCount", Int64.Type}, {"EmployeeNumber", Int64.Type}, {"EnvironmentSatisfaction", Int64.Type},
        {"Gender", type text}, {"HourlyRate", Int64.Type}, {"JobInvolvement", Int64.Type}, {"JobLevel", Int64.Type},
        {"JobRole", type text}, {"JobSatisfaction", Int64.Type}, {"MaritalStatus", type text}, {"MonthlyIncome", Int64.Type},
        {"MonthlyRate", Int64.Type}, {"NumCompaniesWorked", Int64.Type}, {"Over18", type text}, {"OverTime", type text},
        {"PercentSalaryHike", Int64.Type}, {"PerformanceRating", Int64.Type}, {"RelationshipSatisfaction", Int64.Type},
        {"StandardHours", Int64.Type}, {"StockOptionLevel", Int64.Type}, {"TotalWorkingYears", Int64.Type},
        {"TrainingTimesLastYear", Int64.Type}, {"WorkLifeBalance", Int64.Type}, {"YearsAtCompany", Int64.Type},
        {"YearsInCurrentRole", Int64.Type}, {"YearsSinceLastPromotion", Int64.Type}, {"YearsWithCurrManager", Int64.Type}
    })
in
    Typed

// ---------- Query 2: Employees (reporting table, load enabled) ----------
let
    Source  = Raw_Attrition,
    // Step: trim/clean every text column (defensive for future refreshes)
    TextCols = {"Attrition","BusinessTravel","Department","EducationField","Gender","JobRole","MaritalStatus","OverTime"},
    Cleaned = List.Accumulate(TextCols, Source, (t, c) => Table.TransformColumns(t, {{c, each Text.Trim(Text.Clean(_)), type text}})),
    // Step: drop constant columns (EmployeeCount=1, Over18=Y, StandardHours=80)
    Dropped = Table.RemoveColumns(Cleaned, {"EmployeeCount","Over18","StandardHours"}),
    // Step: numeric flag - faster and simpler than text comparison in DAX
    Flag    = Table.AddColumn(Dropped, "AttritionFlag", each if [Attrition] = "Yes" then 1 else 0, Int64.Type),

    // Step: buckets (+ sort-order columns so charts don't sort alphabetically)
    AgeG    = Table.AddColumn(Flag, "AgeGroup", each if [Age] < 25 then "18-24" else if [Age] < 35 then "25-34" else if [Age] < 45 then "35-44" else if [Age] < 55 then "45-54" else "55+", type text),
    AgeS    = Table.AddColumn(AgeG, "AgeGroupSort", each if [Age] < 25 then 1 else if [Age] < 35 then 2 else if [Age] < 45 then 3 else if [Age] < 55 then 4 else 5, Int64.Type),
    TenG    = Table.AddColumn(AgeS, "TenureBucket", each if [YearsAtCompany] < 2 then "0-1 yrs" else if [YearsAtCompany] < 5 then "2-4 yrs" else if [YearsAtCompany] < 10 then "5-9 yrs" else if [YearsAtCompany] < 20 then "10-19 yrs" else "20+ yrs", type text),
    TenS    = Table.AddColumn(TenG, "TenureBucketSort", each if [YearsAtCompany] < 2 then 1 else if [YearsAtCompany] < 5 then 2 else if [YearsAtCompany] < 10 then 3 else if [YearsAtCompany] < 20 then 4 else 5, Int64.Type),
    IncG    = Table.AddColumn(TenS, "IncomeBand", each if [MonthlyIncome] < 3000 then "Under 3k" else if [MonthlyIncome] < 5000 then "3k-5k" else if [MonthlyIncome] < 8000 then "5k-8k" else if [MonthlyIncome] < 12000 then "8k-12k" else "12k+", type text),
    IncS    = Table.AddColumn(IncG, "IncomeBandSort", each if [MonthlyIncome] < 3000 then 1 else if [MonthlyIncome] < 5000 then 2 else if [MonthlyIncome] < 8000 then 3 else if [MonthlyIncome] < 12000 then 4 else 5, Int64.Type),
    ExpG    = Table.AddColumn(IncS, "ExperienceBucket", each if [TotalWorkingYears] < 3 then "0-2 yrs" else if [TotalWorkingYears] < 6 then "3-5 yrs" else if [TotalWorkingYears] < 11 then "6-10 yrs" else if [TotalWorkingYears] < 21 then "11-20 yrs" else "21+ yrs", type text),
    PromG   = Table.AddColumn(ExpG, "PromotionGap", each if [YearsSinceLastPromotion] = 0 then "This year" else if [YearsSinceLastPromotion] < 3 then "1-2 yrs" else if [YearsSinceLastPromotion] < 6 then "3-5 yrs" else "6+ yrs", type text),
    DistG   = Table.AddColumn(PromG, "CommuteBand", each if [DistanceFromHome] < 6 then "1-5" else if [DistanceFromHome] < 11 then "6-10" else if [DistanceFromHome] < 21 then "11-20" else "21+", type text),

    // Step: satisfaction labels (ASSUMPTION: standard 1-4 scale, confirm with data owner)
    Lbl     = (n as nullable number) as text => if n = 1 then "Low" else if n = 2 then "Medium" else if n = 3 then "High" else if n = 4 then "Very High" else "Unknown",
    JS      = Table.AddColumn(DistG, "JobSatisfactionLevel", each Lbl([JobSatisfaction]), type text),
    ES      = Table.AddColumn(JS, "EnvironmentSatisfactionLevel", each Lbl([EnvironmentSatisfaction]), type text),
    WL      = Table.AddColumn(ES, "WorkLifeBalanceLevel", each Lbl([WorkLifeBalance]), type text),
    JI      = Table.AddColumn(WL, "JobInvolvementLevel", each Lbl([JobInvolvement]), type text),
    RS      = Table.AddColumn(JI, "RelationshipSatisfactionLevel", each Lbl([RelationshipSatisfaction]), type text)
in
    RS

// ---------- Query 3: DQ_Summary (data-quality checks, refreshes with data) ----------
let
    T = Raw_Attrition,
    Result = #table(type table [Check = text, Value = number, Expected = text], {
        {"Row count", Table.RowCount(T), "1470 for current file"},
        {"Duplicate EmployeeNumber", Table.RowCount(T) - List.Count(List.Distinct(T[EmployeeNumber])), "0"},
        {"Null cells (all columns)", List.Sum(List.Transform(Table.ColumnNames(T), (c) => List.Count(List.Select(Table.Column(T, c), each _ = null or _ = "")))), "0"},
        {"Attrition values not Yes/No", List.Count(List.Select(T[Attrition], each _ <> "Yes" and _ <> "No")), "0"},
        {"Negative income or age", List.Count(List.Select(T[MonthlyIncome], each _ <= 0)) + List.Count(List.Select(T[Age], each _ <= 0)), "0"}
    })
in
    Result
