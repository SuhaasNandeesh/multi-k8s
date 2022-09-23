docker build -t suhaasnandeesh/multi-client:latest -t suhaasnandeesh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t suhaasnandeesh/multi-server:latest -t suhaasnandeesh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t suhaasnandeesh/multi-worker:latest -t suhaasnandeesh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push suhaasnandeesh/multi-client:latest
docker push suhaasnandeesh/multi-server:latest
docker push suhaasnandeesh/multi-worker:latest

docker push suhaasnandeesh/multi-client:$SHA
docker push suhaasnandeesh/multi-server:$SHA
docker push suhaasnandeesh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=suhaasnandeesh/multi-server:$SHA
kubectl set image deployments/client-deployment client=suhaasnandeesh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=suhaasnandeesh/multi-worker:$SHA