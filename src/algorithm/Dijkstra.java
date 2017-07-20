package algorithm;

import java.util.*;//Scanner Function to take in the Input Values

public class Dijkstra {
	
	public static ArrayList<Integer> main(int[][] matrix,int n){
		int[] preD = new int[n];
		int min = 999, nextNode = 0; // min holds the minimum value, nextNode holds the value for the next node.
		int[] distance = new int[n]; // the distance matrix
		ArrayList<Integer> path = new ArrayList<Integer>();
		int[] visited = new int[n]; // the visited array	
		for(int i = 0; i < distance.length; i++)
		{			
			visited[i] = 0; //initialize visited array to zeros			
			preD[i] = 0;			
			for(int j = 0; j < distance.length; j++){							
				if(matrix[i][j]==0){					
					matrix[i][j] = 999; // make the zeros as 999					
				}				
			}			
		}
		for(int i = 0; i < distance.length; i++){			
			for(int j = 0; j < distance.length; j++){												
					System.out.println("matrix["+i+"]["+j+"] : "+matrix[i][j]);					
				}				
			}
		distance = matrix[0]; //initialize the distance array
		visited[0] = 1; //set the source node as visited
		distance[0] = 0; //set the distance from source to source to zero which is the starting point		
		for(int counter = 0; counter < n; counter++)
		{			
			min = 999;			
			for(int i = 0; i < n; i++)
			{				
				if(min > distance[i] && visited[i]!=1)
				{					
					min = distance[i];
					nextNode = i;					
				}				
			}			
			visited[nextNode] = 1;			
			for(int i = 0; i < n; i++)
			{				
				if(visited[i]!=1)
				{					
					if(min+matrix[nextNode][i] < distance[i])
					{						
						distance[i] = min+matrix[nextNode][i];
						preD[i] = nextNode;						
					}					
				}				
			 }		
		}
		int minD = 999;
		int IndexminD = 0;
		for(int i = 1; i < n; i++){		
			if(minD>distance[i])
			{
				minD=distance[i];
				IndexminD=i;
			}
			System.out.print("|" + distance[i]);			
		}
		System.out.println("|");		
		int j;
		System.out.println("index "+IndexminD);
		int i = IndexminD+1;
		System.out.print("i = " + i);
			if(i!=0){
				path.add(i);
				System.out.print("Path = " + i);
				j = i;
				do{
					j=preD[j];
					path.add(j);
					System.out.print(" <- " + j);
				}while(j!=0);	
			}
			System.out.println();
			return path;
	}	
}

