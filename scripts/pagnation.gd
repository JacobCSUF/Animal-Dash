extends HBoxContainer
class_name Pageination

const PAGE_DOT = preload("uid://cihhs64uxc1ot")


var page_dots: Array[PageDots] = []
	
	

func set_dots(level_dict):
	var is_locked = false
	
	for i in level_dict:
		
		var d: PageDots = PAGE_DOT.instantiate()

		add_child(d)
		page_dots.append(d)
		
		if SaveManager.is_level_locked(i):
			is_locked = true
			d.toggle_lock_on()
			continue

		if i == 0:
			d.toggle_on()

		elif is_locked:
			d.toggle_gray()
		
func toggle_dots(ind):
	for i in range(page_dots.size()):
		if i == ind:
			page_dots[i].toggle_on()
		else:
			page_dots[i].toggle_off()
			
			
func toggle_grays():
	for i in page_dots:
		if i.is_gray:
			i.toggle_color()
			
func unlock(ind: int):
	page_dots[ind].open_lock()

func deny_lock(ind: int,count: int):
	page_dots[ind].deny_lock(count)
