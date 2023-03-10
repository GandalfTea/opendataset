
function log(request: string, client: string, et: number, status: number, msg: string, ...args) {
	const len_req : number = 6 - request.length;
	const date = new Date();
	process.stdout.write(`\n[ ${request}${"".padStart(len_req)} ${status} ${client}  ${date.getFullYear()}-${date.getMonth()}-${date.getDate()}T${date.toLocaleTimeString()} ] : ${msg}`.padEnd(113));
	process.stdout.write(`${(et*1e-6).toFixed(2) }ms`)
}

export default log;
