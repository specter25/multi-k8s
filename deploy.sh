docker build -t ujjwal25/multi-client:latest -t ujjwal25/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ujjwal25/multi-server:latest -t ujjwal25/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ujjwal25/multi-worker:latest -t ujjwal25/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ujjwal25/multi-client:latest
docker push ujjwal25/multi-client:$SHA

docker push ujjwal25/multi-server:latest
docker push ujjwal25/multi-server:$SHA

docker push ujjwal25/multi-worker:latest
docker push ujjwal25/multi-worker:$SHA

kubectl applu -f k8s

kubectl set image deployments/server-deployment server=ujjwal25/multi-server:$SHA 
kubectl set image deployments/client-deployment client=ujjwal25/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ujjwal25/multi-worker:$SHA