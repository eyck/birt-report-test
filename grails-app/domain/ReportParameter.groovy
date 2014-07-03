class ReportParameter {
	static belongsTo = [report: Report]

	String name
	String datatype
	String prompttext
	Boolean allowblank
}
