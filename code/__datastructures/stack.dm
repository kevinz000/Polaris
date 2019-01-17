/datum/stack
	var/list/stack
	var/max_elements = 0

/datum/stack/New(list/elements, max)
	..()
	stack = elements ? elements.Copy() : list()
	if(max)
		max_elements = max

/datum/stack/Destroy()
	stack = null
	. = ..()

/datum/stack/proc/Pop()
	if(is_empty())
		return
	. = stack[stack.len]
	stack.Cut(stack.len,0)

/datum/stack/proc/Push(element)
	if(max_elements && (stack.len + 1 > max_elements))
		return FALSE
	stack += element
	return TRUE

/datum/stack/proc/Top()
	. = is_empty()? null : stack[stack.len]

/datum/stack/proc/Bottom()
	. = is_empty()? null : stack[1]

/datum/stack/proc/Remove(element)
	stack -= element

/datum/stack/proc/IsEmpty()
	. = stack.len ? 0 : 1

//Rotate entire stack left with the leftmost looping around to the right
/datum/stack/proc/RotateLeft()
	if(is_empty())
		return 0
	. = stack[1]
	stack.Cut(1,2)
	push(.)

//Rotate entire stack to the right with the rightmost looping around to the left
/datum/stack/proc/RotateRight()
	if(is_empty())
		return 0
	. = stack[stack.len]
	stack.Cut(stack.len,0)
	stack.Insert(1,.)

/datum/stack/proc/Copy()
	var/datum/stack/S = new
	S.stack = stack.Copy()
	S.max_elements = max_elements
	return S

/datum/stack/proc/Clear()
	stack.Cut()

/datum/stack/proc/QdelClear()
	for(var/entry in stack)
		qdel(entry)
	stack.Cut()