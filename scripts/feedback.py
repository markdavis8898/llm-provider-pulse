#!/usr/bin/env python3
"""
LLM Provider Pulse — Feedback Collector
Collects user feedback on provider performance and reliability.
"""
import json
import os
import sys
from datetime import datetime

FEEDBACK_DIR = os.path.join(os.path.dirname(__file__), '..', 'data', 'results')
FEEDBACK_FILE = os.path.join(FEEDBACK_DIR, 'feedback.json')


def submit_feedback(provider: str, rating: int, comment: str = ""):
    """Submit feedback for a provider."""
    os.makedirs(FEEDBACK_DIR, exist_ok=True)
    
    feedback = []
    if os.path.exists(FEEDBACK_FILE):
        with open(FEEDBACK_FILE) as f:
            feedback = json.load(f)
    
    feedback.append({
        'provider': provider,
        'rating': max(1, min(5, rating)),
        'comment': comment.strip()[:500],
        'submitted_at': datetime.utcnow().isoformat()
    })
    
    with open(FEEDBACK_FILE, 'w') as f:
        json.dump(feedback, f, indent=2, ensure_ascii=False)
    
    print(f"✅ Feedback recorded for {provider} (rating: {rating}/5)")


def list_feedback(provider: str = None):
    """List all feedback, optionally filtered by provider."""
    if not os.path.exists(FEEDBACK_FILE):
        print("No feedback data yet.")
        return
    
    with open(FEEDBACK_FILE) as f:
        feedback = json.load(f)
    
    if provider:
        feedback = [fb for fb in feedback if fb['provider'].lower() == provider.lower()]
    
    if not feedback:
        print(f"No feedback for '{provider or 'any provider'}'")
        return
    
    print(f"\nFeedback entries: {len(feedback)}")
    for fb in feedback:
        stars = "⭐" * fb['rating']
        print(f"  {fb['provider']:25} {stars}  {fb.get('comment','')[:100]}")
        print(f"    ({fb['submitted_at'][:16]})")


def summary():
    """Show aggregated summary of all feedback."""
    if not os.path.exists(FEEDBACK_FILE):
        print("No feedback data yet.")
        return
    
    with open(FEEDBACK_FILE) as f:
        feedback = json.load(f)
    
    from collections import defaultdict
    ratings = defaultdict(list)
    for fb in feedback:
        ratings[fb['provider']].append(fb['rating'])
    
    print("\n=== Provider Feedback Summary ===")
    for provider, rlist in sorted(ratings.items()):
        avg = sum(rlist) / len(rlist)
        print(f"  {provider:25} ⭐ {avg:.1f}/5  ({len(rlist)} reviews)")


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage:")
        print("  feedback.py submit <provider> <rating(1-5)> [comment]")
        print("  feedback.py list [provider]")
        print("  feedback.py summary")
        sys.exit(1)
    
    action = sys.argv[1]
    if action == 'submit':
        if len(sys.argv) < 4:
            print("Usage: feedback.py submit <provider> <rating> [comment]")
            sys.exit(1)
        submit_feedback(sys.argv[2], int(sys.argv[3]), ' '.join(sys.argv[4:]))
    elif action == 'list':
        list_feedback(sys.argv[2] if len(sys.argv) > 2 else None)
    elif action == 'summary':
        summary()
    else:
        print(f"Unknown action: {action}")
