#!/usr/bin/env python3

import json

d = {}
with open('watch_list.txt', 'r') as f:
    L = f.read().splitlines()
    f.close()

def make_dict(name):
    return{
            "addPaused": None,
            "affectedFeeds": ["https://subsplease.org/rss/?t&r=720"],
            "assignedCategory": "Anime",
            "enabled": True,
            "episodeFilter": "",
            "ignoreDays": 0,
            "lastMatch": None,
            "mustContain": name,
            "mustNotContain": "Batch",
            "previouslyMatchedEpisodes": [],
            "savePath": "/home/rudo/Videos/Anime/Currently_watching",
            "smartfilter": False,
            "useRegex": False}

for i in L:
    d[i] = make_dict(i)

with open('weeb.json', 'w') as weeb:
    weeb.write(json.dumps(d, indent=4))
    weeb.close()
