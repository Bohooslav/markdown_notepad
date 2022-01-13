class State
	pages = []
	current_page = 0
	get page
		return pages[current_page]


	def constructor
		pages = JSON.parse(getCookie('pages')) || []
		unless pages.length
			addNewPage!
		current_page = parseInt(getCookie('current_page')) || 0

	def savePages
		setCookie('pages', JSON.stringify(pages))

	def getCookie c_name
		return window.localStorage.getItem(c_name)

	def setCookie c_name, value
		window.localStorage.setItem(c_name, value)

	def randString
		Math.random().toString(36).slice(2)

	def uniqueID used_ids = []
		unless used_ids.length
			for page in pages
				used_ids.push(page.id)

		let id = randString! + randString!
		if id in used_ids
			return uniqueID used_ids
		return id

	def addNewPage
		let now = new Date(Date.now!)
		let text = "# Fresh page № {pages.length + 1}\nCreated at " + now.toLocaleString!
		current_page = pages.length
		pages.push {
			id: uniqueID!
			title: text
			text: text
		}
		setCookie('current_page', current_page)
		savePages!


	def copyObj obj\object
		return JSON.parse(JSON.stringify(obj))

	# def loadData url
	# 	let res = await window.fetch url
	# 	return res.json




let state = new State

extend tag Element
	get state
		return state
