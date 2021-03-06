## Put comments here that give an overall description of what your
## functions do
## This is the work for week 3's assignment

## Write a short comment describing this function
## makeCacheMatrix: create a special matrix object 
##      that can cache it inverse
##      
makeCacheMatrix <- function(x = matrix()) {
    invs <- NULL
    
    ## return the underlying matrix
    get <- function() x
    
    ## return the inverse matrix
    getinverse <- function() invs
    
    ## assign value to the matrix itself
    set <- function(y) {
        x <<- y
        invs <<- NULL ## new matrix has no cached inverse
    }
    
    ## set the cached inverse. The inverse matrix is checked 
    ## before being cached actually
    setinverse <- function(inverse) {
        # check the inverse matrix before caching
        checkinverse <- get() %*% inverse
        midentity <- diag(dim(get())[1])    #identity matrix
        
        if (identical(checkinverse, midentity)){
            invs <<- inverse    
        }else {
            message('Not the correct inverse matrix to be cached')
        }
    }
    
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## Write a short comment describing this function
## cacheSolve: computes the inverse of the special "matrix" 
##      returned by makeCacheMatrix. 
##      If the inverse has already been calculated 
##      (and the matrix has not changed), 
##      then the cachesolve should retrieve the inverse from the cache

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    invs <- x$getinverse()
    
    if ( !is.null(invs) ) {
        # the matrix is unchanged
        message('Retriving the inverse matrix from cache')
        return(invs)
    }
    message('Calculate the inverse matrix')
    thematrix <- x$get()
    invs <- solve(thematrix)
    x$setinverse(invs)
    invs
}
