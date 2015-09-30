---
layout: post
title:  "E2E Testing Strategy"
date:   2015-09-30 01:13:15
author: Brandon Cole
categories: Testing
tags:	 testing e2e automated
---

More tests!  More tests are always better, right?  Let's reconsider, before answering that.

Recently, I have been given responsibilities related to end-to-end (E2E) testing for a web application.  The web application is primarily written in [AngularJS][angular], and I am using the [Protractor][protractor] testing framework provided by the Angular team to write my tests.

Now, I come from a testing background of low-level tests.  Unit tests, integration tests, service tests.  I'm new to UI and E2E tests.  When I write unit tests, I write unit tests.  I test positive and negative flows, I try to hit all boundary and edge cases, and so on.  Same for service tests.  And so, when it came time for me to write E2E tests, it made sense to follow that mindset.

I tried testing every possible permutation of user experience options I could think of, positive flows and the more unlikely negative flows.  The number of permutations grew very, very quickly; multiplying as I found a new option that the user could try.  I was testing a relatively minor feature, and I quickly realized how unmaintainable this was becoming.

Not only did this stress me out trying to properly set up a test suite of this size, but I was realizing a number of other side effects.

**1) Tests had to be frequently maintained.**

My tests had to, of course, make assertions to validate what should be displayed on the screen.  I abstracted out assertion values into test data files, so that as I was testing different environments (QA, Prod) or regions (US, UK), it was "easy" to make changes that reflect the given test.

However, assertions were failing far more often than I expected.  Marketing would change a price value on the screen, experience designers would change the wording of a page, or database tables would simply change over time (as data tends to do in a web app!).

*Changes that didn't impact the user experience flow were causing my tests to break.*

The test data would constantly have to be maintained to account for the web application's ever-changing state.

**2) Tests were becoming brittle.**

Besides the changing state of the web application causing tests to fail, user interface tests present some challenges of their own.  There are often additional race conditions or timeout considerations that need to be carefully mitigated in the test to prevent intermittent test failures.

*Tests that fail intermittently are useless.*

You and any team members will start ignoring failed tests, thinking it's another false positive (and perhaps it is).  A failed test should be taken seriously, and a testing strategy that does not foster that attitude is not benefiting you.

**3) Test execution times were too long.**

A test suite that takes too long to execute will not be run frequently.  Code ends up being checked in without thorough testing.

All of these side effects, and more, were hindering our team's ability to produce quality software.

So what ***should*** we do?  I'm glad you asked.

###The Testing Pyramid

![Testing Pyramid][img-test-pyramid]

[Martin Fowler][fowler] discusses a concept called the Testing Pyramid.  Essentially, there should be more unit tests than service or integration tests, and more of those than UI or E2E tests.

He mentions the anti-pattern for this, comically referred to as the [Ice Cream Cone][watirmelon] anti-pattern.

<img src="/assets/ice-cream-anti-pattern.png" alt="Ice Cream Cone anti-pattern" style="max-width: 520px">

The [Ice Cream Cone anti-pattern][watirmelon], which is what I was striving for as I naively took on my E2E testing responsibilities, causes the exact problems outlined above.

### The Strategy

As tempting as it is, avoid the Ice Cream Cone!  Here's what I suggest.

Keep E2E tests focused on the core flows of your application that your users will engage in.  Don't test for specific content, like text or images.  These can change frequently.  Instead, test for more static items.  Test buttons and links and ensure their behavior is as expected.

Save your animal-like instincts of software quality with wild test permutations for the lower-level unit and service tests.  It's much easier to test a wide set of test inputs at the unit level.  Unit tests aren't dependent on the state of the web application or what is in the database.

One final benefit I'll briefly mention is discussed in detail in a [recent blog post][google-post] from the Google testing blog.  Taking a step back, what is the point of testing?  To find bugs!  If a high level E2E test fails, it could be caused by any number of problems.  Isolating the buggy code can be quite difficult if a bug is found in an E2E test.  Conversely, a unit test failure isolates the possible buggy code to a much smaller scope.  It is much easier to resolve the bug.

### So, is more testing always better?!

That was a trick question, wasn't it?

Writing the right kind of tests is what's important.  Write more unit tests, and limit your end-to-end tests.

### Read More!

Please, don't just take my suggestions without further thought.  There is a large amount of information surfacing, especially recently, on best practices for testing.

I highly suggest reading [Google's recent blog post][google-post] on E2E testing.  It's a bit lengthy but it's worthwhile.

Martin Fowler's post on the [Test Pyramid][fowler] is great as well (and it's a quick read!).

Let me know if you have any experiences of your own you'd like to share!


[angular]: https://angularjs.org/
[protractor]: https://angular.github.io/protractor/#/
[fowler]: http://martinfowler.com/bliki/TestPyramid.html
[watirmelon]: http://watirmelon.com/2012/01/31/introducing-the-software-testing-ice-cream-cone/
[google-post]: http://googletesting.blogspot.co.uk/2015/04/just-say-no-to-more-end-to-end-tests.html
[img-test-pyramid]: /assets/test-pyramid.png