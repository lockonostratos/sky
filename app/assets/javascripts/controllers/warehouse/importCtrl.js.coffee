Sky.controller 'importCtrl', ['$routeParams', 'Common', 'TempImport', 'TempImportDetail'
($routeParams, Common, TempImport, TempImportDetail) ->
  Common.caption = 'nhập kho'
  @message = 'message from import'

  @currentImport = new TempImport()
  TempImport.query().then (data) -> @currentImport = data if data

  @currentDetails = []
  TempImportDetail.query().then (data) -> @currentDetails = data

  @saveImportHeaders = ->
    @currentImport.update()
    console.log 'saving..'

  @employees = [{    "EmployeeID": 1,    "LastName": "Davolio",    "FirstName": "Nancy",    "Title": "Sales Representative",    "TitleOfCourtesy": "Ms.",    "BirthDate": "1968-12-08T00:00:00.000Z",    "HireDate": "2011-05-01T00:00:00.000Z",    "Address": "507 - 20th Ave. E.\r\nApt. 2A",    "City": "Seattle",    "Region": "WA",    "PostalCode": "98122",    "Country": "USA",    "HomePhone": "(206) 555-9857",    "Extension": "5467",    "Photo": "images/employees/01.jpg",    "Notes": "Education includes a BA in psychology from Colorado State University in 1990.  She also completed \"The Art of the Cold Call.\"  Nancy is a member of Toastmasters International.",    "ReportsTo": 2}, {    "EmployeeID": 2,    "LastName": "Fuller",    "FirstName": "Andrew",    "Title": "Vice President, Sales",    "TitleOfCourtesy": "Dr.",    "BirthDate": "1972-02-19T00:00:00.000Z",    "HireDate": "2011-08-14T00:00:00.000Z",    "Address": "908 W. Capital Way",    "City": "Tacoma",    "Region": "WA",    "PostalCode": "98401",    "Country": "USA",    "HomePhone": "(206) 555-9482",    "Extension": "3457",    "Photo": "images/employees/02.jpg",    "Notes": "Andrew received his BTS commercial in 1994 and a Ph.D. in international marketing from the University of Dallas in 2001.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 2012 and to vice president of sales in March 2013.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.",    "ReportsTo": null}, {    "EmployeeID": 3,    "LastName": "Leverling",    "FirstName": "Janet",    "Title": "Sales Representative",    "TitleOfCourtesy": "Mrs.",    "BirthDate": "1978-08-30T00:00:00.000Z",    "HireDate": "2011-04-01T00:00:00.000Z",    "Address": "722 Moss Bay Blvd.",    "City": "Kirkland",    "Region": "WA",    "PostalCode": "98033",    "Country": "USA",    "HomePhone": "(206) 555-3412",    "Extension": "3355",    "Photo": "images/employees/03.jpg",    "Notes": "Janet has a BS degree in chemistry from Boston College (1999).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 2011 and promoted to sales representative in February 2002.",    "ReportsTo": 2}, {    "EmployeeID": 4,    "LastName": "Purtell",    "FirstName": "Arthur",    "Title": "Sales Representative",    "TitleOfCourtesy": "Mr.",    "BirthDate": "1957-09-19T00:00:00.000Z",    "HireDate": "2012-05-03T00:00:00.000Z",    "Address": "4110 Old Redmond Rd.",    "City": "Redmond",    "Region": "WA",    "PostalCode": "98052",    "Country": "USA",    "HomePhone": "(206) 555-8122",    "Extension": "5176",    "Photo": "images/employees/04.jpg",    "Notes": "Arthur holds a BA in English literature from Concordia College (1978) and an MA from the American Institute of Culinary Arts (1986).  He was assigned to the London office temporarily from July through November 2012.",    "ReportsTo": 2}, {    "EmployeeID": 5,    "LastName": "Buchanan",    "FirstName": "Steven",    "Title": "Sales Manager",    "TitleOfCourtesy": "Mr.",    "BirthDate": "1975-03-04T00:00:00.000Z",    "HireDate": "2012-10-17T00:00:00.000Z",    "Address": "14 Garrett Hill",    "City": "London",    "Region": null,    "PostalCode": "SW1 8JR",    "Country": "UK",    "HomePhone": "(71) 555-4848",    "Extension": "3453",    "Photo": "images/employees/05.jpg",    "Notes": "Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1996.  Upon joining the company as a sales representative in 2012, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 2013.  Mr. Buchanan has completed the courses \"Successful Telemarketing\" and \"International Sales Management.\"  He is fluent in French.",    "ReportsTo": 2}, {    "EmployeeID": 6,    "LastName": "Suyama",    "FirstName": "Michael",    "Title": "Sales Representative",    "TitleOfCourtesy": "Mr.",    "BirthDate": "1983-07-02T00:00:00.000Z",    "HireDate": "2012-10-17T00:00:00.000Z",    "Address": "Coventry House\r\nMiner Rd.",    "City": "London",    "Region": null,    "PostalCode": "EC2 7JR",    "Country": "UK",    "HomePhone": "(71) 555-7773",    "Extension": "428",    "Photo": "images/employees/06.jpg",    "Notes": "Michael is a graduate of Sussex University (MA, economics, 2003) and the University of California at Los Angeles (MBA, marketing, 2006).  He has also taken the courses \"Multi-Cultural Selling\" and \"Time Management for the Sales Professional.\"  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.",    "ReportsTo": 5}, {    "EmployeeID": 7,    "LastName": "King",    "FirstName": "Robert",    "Title": "Sales Representative",    "TitleOfCourtesy": "Mr.",    "BirthDate": "1980-05-29T00:00:00.000Z",    "HireDate": "2012-01-02T00:00:00.000Z",    "Address": "Edgeham Hollow\r\nWinchester Way",    "City": "London",    "Region": null,    "PostalCode": "RG1 9SP",    "Country": "UK",    "HomePhone": "(71) 555-5598",    "Extension": "465",    "Photo": "images/employees/07.jpg",    "Notes": "Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 2002, the year he joined the company.  After completing a course entitled Selling in Europe, he was transferred to the London office in March 2013.",    "ReportsTo": 5}, {    "EmployeeID": 8,    "LastName": "Callahan",    "FirstName": "Laura",    "Title": "Inside Sales Coordinator",    "TitleOfCourtesy": "Ms.",    "BirthDate": "1978-01-09T00:00:00.000Z",    "HireDate": "2012-03-05T00:00:00.000Z",    "Address": "4726 - 11th Ave. N.E.",    "City": "Seattle",    "Region": "WA",    "PostalCode": "98105",    "Country": "USA",    "HomePhone": "(206) 555-1189",    "Extension": "2344",    "Photo": "images/employees/08.jpg",    "Notes": "Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.",    "ReportsTo": 2}, {    "EmployeeID": 9,    "LastName": "Dodsworth",    "FirstName": "Anne",    "Title": "Sales Representative",    "TitleOfCourtesy": "Ms.",    "BirthDate": "1986-01-27T00:00:00.000Z",    "HireDate": "2012-11-15T00:00:00.000Z",    "Address": "7 Houndstooth Rd.",    "City": "London",    "Region": null,    "PostalCode": "WG2 7LT",    "Country": "UK",    "HomePhone": "(71) 555-4444",    "Extension": "452",    "Photo": "images/employees/09.jpg",    "Notes": "Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.",    "ReportsTo": 5}]

  @dataGridOptions =
    bindingOptions:
      dataSource: 'employees'
    paging:
      enabled: false
    editing:
      editMode: 'row'
      editEnabled: true
      removeEnabled: true
      insertEnabled: true
      removeConfirmMessage: "Are you sure you want to delete this record?"
    selection:
      mode: 'multiple'
    columns: [
      {
        dataField: 'TitleOfCourtesy'
        caption: "Title"
        width: 70
      },
      'FirstName',
      'LastName', {
        dataField: 'Title'
        caption: "Position"
        width: 170
      }, {
        dataField: 'BirthDate'
        dataType: 'date'
        caption: 'Birthdate'
        width: 90
      }, {
        dataField: 'HireDate'
        dataType: 'date'
        width: 90
      }
    ]

  return
]