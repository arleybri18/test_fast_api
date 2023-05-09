import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.v1.users import users

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(users)


@app.on_event("startup")
def startup():
    print("Starting")
    print(f'Environment: {os.getenv("APP_ENV")}')


@app.on_event("shutdown")
def shutdown():
    print("Server down")


@app.get("/healthcheck", include_in_schema=False)
async def healthcheck():
    return {"status": "ok"}
