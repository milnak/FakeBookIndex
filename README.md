# FakeBook Index

Started July 2024.

## What is this?

A collection of "open source" fake book indexes which I've created as JSON based on various lists I've found and have been able to scrape.

## Why did I create this?

I've created these as I couldn't find an "open" fake book indexes -- theres some that are PDF that can't be converted to other formats. There's others that are in a proprietary binary format. And there's web sites that have searchable indexes, but you can't use them offline or convert them to other formats.

## Where can I get these?

Do not ask me where you can find these books online. Check your favorite book seller. If they have it, buy it there. If not, I can't help you out, so please don't ask.

## Format

The JSON files have a simple "Page", "Title", "Composer" schema.  That seems good enough for me, at least for now.

There's loads of tools across all platforms that can convert JSON to almost any format you like.  For example, on Windows one could convert the JSON to a printable table using:

```PowerShell
Get-Content '.\Spaces 2.json' | ConvertFrom-Json | Format-Table
```

If you're having trouble converting these to a format that you'd like, send a message and I'll see if I can help.

## I found a mistake, or a book is missing!

I accept pull requests, which is why this is "open source". Please send any corrections!  If you're not sure how to do a github pull request, no problem. Send me a message and I'll do my best to fix it up.
