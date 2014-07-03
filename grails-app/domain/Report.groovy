class Report {
	static hasMany = [ reportParameters : ReportParameter ]

	String author
	String title
	String createdBy
	String description
	String comment
	String units
	String helpGuide
	String name
	String file
	String fullfile
}
