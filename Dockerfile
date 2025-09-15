# Use Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY src/ ./src/
COPY config/ ./config/
COPY fantasy_football_multi_league.py ./
COPY pyproject.toml ./

# Set environment to production
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

# Expose port for HTTP streaming MCP server
EXPOSE 8000

# Set environment variables for HTTP server
ENV PORT=8000
ENV HOST=0.0.0.0

# Start the unified MCP server with HTTP streaming
CMD ["python", "-m", "fantasy_football_multi_league", "--transport", "http"]