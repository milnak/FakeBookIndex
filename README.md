# FakeBook Index

## What is this?

A collection of "open source" fake book indexes which I've created as JSON based on various lists I've found and have been able to scrape.

## Why did I create this?

I've created these as I couldn't find an "open" fake book indexes -- theres some that are PDF that can't be converted to other formats. There's others that are in a closed binary format. And there's web sites that have searchable indexes, but you can't use them offline or convert them to other formats.

## Where can I get these?

Do not ask me where you can find these books online. Check your favorite book seller. If they have it, buy it there. If not, I can't help you out.

## Format

The JSON files have a simple "Page", "Title", "Composer" schema.  That seems good enough for me, at least for now.

There's loads of tools that can convert JSON to almost any format you like.  For example, on Windows one could convert the JSON to a printable table using:

```PowerShell
Get-Content '.\Spaces 2.json' | ConvertFrom-Json | Format-Table
```

## I found a mistake, or a book is missing!

I accept pull requests, which is why this is "open source". Please send any corrections!  If you're not sure how to do a github pull request, no problem. Send me a message and I'll fix it up.