# API Notes

- **Source:** `API Notes.docx`

Endpoint is the URL

What JSON format?

Clean JSON – JSON they will send to our URL

If not doing anything with data – can they not send it? o/w/we need to exclude it

Needs to match Prio form – so capitals

We make an interim form for taking all data, then we choose which Prio form to send to (POST if doing in Prio format) and do GET (nothing in middle, URL exposed

If they care about format – medatech script in the middle. They send their formatted data to med script, med convert and send to interim form. (we need to avoid this)

URL to ODATA form or new form will cols same as cols they send. Then write to load data to relevant form.

They need to send JSON to go directly to Priority.

Forget other MERPO (not how we would write it now)
