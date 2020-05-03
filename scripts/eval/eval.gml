var statement = argument0

var pg = txr_compile(statement)
th = txr_thread_create(pg)
var response = txr_thread_resume(th)
txr_thread_yield()

if string_length(txr_error) > 0 {
	log(string("\t" + txr_error))
} else {
	log(string(th[txr_thread.result]))
}

txr_error = ""