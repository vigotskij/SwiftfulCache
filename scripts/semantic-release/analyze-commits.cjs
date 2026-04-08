const RELEASE_PRIORITY = {
  patch: 1,
  minor: 2,
  major: 3,
};

function maxRelease(current, next) {
  if (!current) return next;
  if (!next) return current;
  return RELEASE_PRIORITY[next] > RELEASE_PRIORITY[current] ? next : current;
}

function parseHeader(header) {
  const match = header.match(/^([a-zA-Z]+)(?:\(([^)]+)\))?(!)?:\s+(.+)$/);
  if (!match) return null;

  return {
    type: match[1].toLowerCase(),
    scope: match[2] || null,
    breakingByBang: Boolean(match[3]),
    subject: match[4],
  };
}

function isNoRelease(message) {
  return /\(no-release\)/i.test(message);
}

function isBreakingCommit(message, parsedHeader) {
  return (
    parsedHeader?.breakingByBang === true ||
    /BREAKING[ -]CHANGE:/i.test(message)
  );
}

module.exports = {
  analyzeCommits: async (_, context) => {
    let release = null;

    for (const commit of context.commits) {
      const message = commit.message || "";
      const header = message.split("\n")[0]?.trim() ?? "";
      if (!header) continue;

      if (isNoRelease(message)) {
        context.logger.log("Skipping commit %s due to (no-release)", commit.hash);
        continue;
      }

      const parsedHeader = parseHeader(header);
      if (!parsedHeader) continue;

      if (isBreakingCommit(message, parsedHeader)) {
        release = maxRelease(release, "major");
        continue;
      }

      switch (parsedHeader.type) {
      case "feat":
        release = maxRelease(release, "minor");
        break;
      case "fix":
      case "perf":
      case "chore":
        release = maxRelease(release, "patch");
        break;
      default:
        break;
      }
    }

    if (release) {
      context.logger.log("Determined release type: %s", release);
    } else {
      context.logger.log("No release triggered by commits.");
    }

    return release;
  },
};
