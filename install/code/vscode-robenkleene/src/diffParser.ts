export interface DiffLocation {
	filePath: string;
	line: number;   // 1-indexed
	col: number;    // 1-indexed
}

export function parseDiffLocation(text: string, targetLine: number): DiffLocation | null {
	const lines = text.split('\n');
	if (targetLine < 0 || targetLine >= lines.length) {
		return null;
	}

	let aPath = '';
	let bPath = '';
	let oldLn = 0;
	let newLn = 0;
	let hunkActive = false;

	for (let i = 0; i <= targetLine; i++) {
		const l = lines[i];

		// diff --git a/... b/...
		const gitMatch = l.match(/^diff --git a\/(.*?)\s+b\/(.+)$/);
		if (gitMatch) {
			aPath = gitMatch[1];
			bPath = gitMatch[2];
			hunkActive = false;
			continue;
		}

		// --- a/... (only outside hunks)
		if (!hunkActive && l.startsWith('--- ')) {
			const m = l.match(/^--- (?:a\/)?(.*)$/);
			if (m && !aPath) {
				aPath = m[1];
			}
			continue;
		}

		// +++ b/... (only outside hunks)
		if (!hunkActive && l.startsWith('+++ ')) {
			const m = l.match(/^\+\+\+ (?:b\/)?(.*)$/);
			if (m && !bPath) {
				bPath = m[1];
			}
			continue;
		}

		// @@ -old,len +new,len @@
		const hunkMatch = l.match(/^@@ -(\d+)(?:,\d+)? \+(\d+)(?:,\d+)? @@/);
		if (hunkMatch) {
			oldLn = parseInt(hunkMatch[1], 10);
			newLn = parseInt(hunkMatch[2], 10);
			hunkActive = true;
			continue;
		}

		if (!hunkActive) {
			continue;
		}

		if (l.startsWith('\\ ')) {
			continue;
		}

		// Inside a hunk
		if (l.startsWith(' ')) {
			if (i === targetLine) {
				const path = bPath || aPath;
				if (path && path !== '/dev/null') {
					return { filePath: path, line: newLn, col: 1 };
				}
			}
			oldLn++;
			newLn++;
		} else if (l.startsWith('+')) {
			if (i === targetLine) {
				const path = bPath || aPath;
				if (path && path !== '/dev/null') {
					return { filePath: path, line: newLn, col: 1 };
				}
			}
			newLn++;
		} else if (l.startsWith('-')) {
			if (i === targetLine) {
				const path = aPath || bPath;
				if (path && path !== '/dev/null') {
					return { filePath: path, line: oldLn, col: 1 };
				}
			}
			oldLn++;
		}
	}

	return null;
}
